import 'dart:async';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../Api/Api.dart';
import '../../Screens/Chat_Page.dart';
import '../../SharedPref/SharedPref.dart';
import '../../DB/AppDB.dart';
import 'package:flutter/services.dart';
import '../../models/Message.dart';
import '../../models/User.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './bloc.dart';

class MassengerBloc extends Bloc<MassengerEvent, MassengerState> {
  final AppDataBase appDataBase;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  MassengerBloc(this.appDataBase) : super(InitialMassengerState()) {



    flutterLocalNotificationsPlugin =
        localLib.FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        localLib.AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = localLib.IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = localLib.InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }
  @override
  void dispose() {
    disconnect();

    for (MessageWidget m in cachMessages) {
      m.animationController?.dispose();
    }
    super.close();
  }

  var platform = MethodChannel('crossingthestreams.io/resourceResolver');
  final String URI =
      "http://ec2-18-222-51-32.us-east-2.compute.amazonaws.com:3000";

  final SocketIOManager manager = SocketIOManager();
  SocketIO socket;
  // cachMessages will handle all messages of one convesation by the time
  final List<MessageWidget> cachMessages = <MessageWidget>[];
  TickerProvider ticker;
  User currentUser;
  String otherId;
  String otherName;
  bool isdequee = false;

  String currentOtherId;
  bool inConversation = false;
  @override
  MassengerState get initialState => InitialMassengerState();

  @override
  Stream<MassengerState> mapEventToState(
    MassengerEvent event,
  ) async* {
    // when user get into the chat page with other person
    if (event is EnterConversation) {
      ticker = event.ticker;
      inConversation = true;
      yield LoadingLocalMessages();

      //this to set all unread messages of this person to read messages
      appDataBase.clearNewMessageNum(event.otherId);
      currentOtherId = event.otherId;
      otherName = event.name;
      otherId = event.otherId;
      // get all messages between me and the other
      await appDataBase.getMessages(otherId).then((onMessages) {
        onMessages.forEach((m) {
          final MessageWidget chatMessage = MessageWidget(
              animationController: null,
              isRecieved: !m.isMine,
              authorName: m.isMine ? currentUser.name ?? "" : otherName,
              text: m.message,
              time: DateTime.fromMillisecondsSinceEpoch(int.parse(m.createdAt))
                      .hour
                      .toString() +
                  ":" +
                  DateTime.fromMillisecondsSinceEpoch(int.parse(m.createdAt))
                      .minute
                      .toString());
          cachMessages.insert(0, chatMessage);
        });
      });
      yield LocalMessagesReady(cachMessages);
    }

// on app startUp
    if (event is Connect) {
      if (this.state is Connected) {
        print("already CONNECT");
      } else {
        yield LoadingConnect();
        currentUser = await SharedPref.pref.getUser();
        //! **********************************************************************************
        Api.apiClient.getQueues(currentUser.id).then((response) {
          appDataBase.recieveCollectionUnread(response["messages"]);
          appDataBase.recieveFolloweeCollection(response["followees"]);
          appDataBase.recieveRevealCollection(response["reveal"]);
          appDataBase.recieveDateCollection(response["date"]);
        });

        await initSocket();
      }
    }

    if (event is RefreashChat) {
      await Api.apiClient.getQueues(currentUser.id).then((response) {
        appDataBase.recieveCollectionUnread(response["messages"]);
        appDataBase.recieveFolloweeCollection(response["followees"]);
        appDataBase.recieveRevealCollection(response["reveal"]);
        appDataBase.recieveDateCollection(response["date"]);
      });
      cachMessages.clear();
      this.add(EnterConversation(otherId, otherName, ticker));
    }
    if (event is ConnectedEvent) {
      if (this.state is LocalMessagesReady) {
        yield Connected();
        yield LocalMessagesReady(cachMessages);
      } else {
        yield Connected();
      }
    }
    if (event is NotConnectedEvent) {
      yield NotConnected(event.error);
    }
    if (event is SuspendAppEvent) {
      disconnect();
      yield SuspendApp();
    }
    // when new message recieved
    if (event is NewMessageEvent) {
      print(event.msg.author);

      // check if the message is from the same person that im chating with right now
      if (event.msg.author == currentOtherId) {
        final MessageWidget message = new MessageWidget(
          animationController: AnimationController(
            duration: new Duration(milliseconds: 700),
            vsync: ticker,
          ),
          isRecieved: true,
          authorName: otherName,
          text: event.msg.message,
          time: DateTime.fromMillisecondsSinceEpoch(event.msg.createdAt)
                  .hour
                  .toString() +
              ":" +
              DateTime.fromMillisecondsSinceEpoch(event.msg.createdAt)
                  .minute
                  .toString(),
        );

        cachMessages.insert(0, message);
        appDataBase.sendRecieveDirect(
            LocalMessage(
                message: event.msg.message,
                createdAt: event.msg.createdAt.toString(),
                isRead: true,
                isMine: false,
                authorId: event.msg.author,
                receiverId: event.msg.reciever),
            false);
        yield MessagesBox(cachMessages);
        message.animationController.forward();
      } else {
        // if not recive it as unread message
        appDataBase.recieveUnread(LocalMessage(
            message: event.msg.message,
            createdAt: event.msg.createdAt.toString(),
            isRead: false,
            isMine: false,
            authorId: event.msg.author,
            receiverId: event.msg.reciever));
      }
    }
    // send message from me
    if (event is SendEvent) {
      sendMessage(event.msg);
    }
    if (event is MessageSentEvent) {
      cachMessages.insert(0, event.message);
      yield MessagesBox(cachMessages);
      event.message.animationController.forward();
    }
    if (event is RevealEventForChat) {
      yield RevealCurrentChatUser(event.newName);
    }
    if (event is Navigate) {
      yield NavigateState(event.payload);
    }
    if (event is LogoutEvent) {
      yield LogedOut();
    }
  }

  initSocket() async {
    try {
      socket = await manager.createInstance(SocketOptions(URI,
          enableLogging: true,
          transports: [Transports.WEB_SOCKET, Transports.POLLING]));
      socket.onConnect((data) async {
        if (socket != null) {
          socket.emit("join", [
            {
              "authorId": currentUser.id,
            },
          ]);

          this.add(ConnectedEvent());
        } else {
          print("unable to get socket real id");
          this.add(NotConnectedEvent("unable to get socket real id"));
        }
      });
      socket.onConnectError((error) {
        this.disconnect();
        this.add(NotConnectedEvent(error.toString()));
      });
      socket.onConnectTimeout((error) {
        this.disconnect();
        //this.add(NotConnectedEvent(error.toString()));
      });
      socket.onError((error) {
        this.disconnect();
        // this.add(NotConnectedEvent(error.toString()));
      });
      socket.onDisconnect((data) {
        print("socket diconnect");
      });
      // callback on message recived
      socket.on("message", (data) {
        print(data.toString());
        if (currentOtherId == null) {
          _showNotification(
              "new Message from ${data["Author"]}", data["message"], "message");
        } else {
          if (currentOtherId != data["Author"]) {
            _showNotification("new Message from ${data["Author"]}",
                data["message"], "message");
          }
        }

        this.add(NewMessageEvent(Message(data["message"], data["createdAt"],
            data["isRead"], data["Author"], data["reciever"])));
      });

      socket.on("reveal", (data) {
        print(data.toString());

        if (data["notify"]) {
          if (currentOtherId != null && data["revealerId"] == currentOtherId) {
            this.add(RevealEventForChat(data["name"]));
          } else {
            _showNotification(
                "${data['nickName']} reveal his identity",
                "his real name is " + data['name'],
                "reveal ${data["revealerId"]}");
          }
        }
        appDataBase.revealIdetity(
            data["revealerId"], data['name'], data['nickName'], data["notify"]);
        appDataBase.newNotification(
            User(
              id: data["revealerId"],
              name: data['name'],
            ),
            "reveal");
      });
      socket.on("date", (data) {
        print(data.toString());
        if (data["notify"]) {
          _showNotification("you have new date ",
              data['name'] + " has date with you", "date ${data["partnerId"]}");
        }
        appDataBase.recieveDateUser(User(
            id: data["partnerId"],
            name: data["name"],
            notify: data["notify"],
            orignallySecret: data["orignallySecret"],
            presentlySecret: data["presentlySecret"],
            profilePhoto: data["profilePhoto"]));
        appDataBase.newNotification(
            User(
              id: data["partnerId"],
              name: data['name'],
            ),
            "date");
      });
      socket.on('followee', (data) {
        print(data.toString());
        if (data["notify"]) {
          _showNotification("you have new followers",
              data['name'] + "has follow you", "followee");
        }
        appDataBase.recieveFolloweeUser(User(
            id: data["_id"],
            name: data["name"],
            orignallySecret: data["orignallySecret"],
            presentlySecret: data["presentlySecret"]));
        appDataBase.newNotification(
            User(
              id: data["_id"],
              name: data['name'],
            ),
            "followee");
      });

      socket.connect();
    } catch (e) {
      print(e);
      this.add(NotConnectedEvent(e.toString()));
    }
  }

  disconnect() async {
    try {
      if (socket != null) {
        await manager?.clearInstance(socket);
      }
    } on PlatformException {
      print("platform exception");
    }
    if (this.state is NotConnected) {
    } else {
      this.add(LogoutEvent());
    }
  }

  sendMessage(Message msg) {
    print(currentUser.name);
    MessageWidget message = MessageWidget(
      animationController: AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: ticker,
      ),
      isRecieved: false,
      authorName: currentUser.name,
      text: msg.message,
      time: DateTime.fromMillisecondsSinceEpoch(msg.createdAt).hour.toString() +
          ":" +
          DateTime.fromMillisecondsSinceEpoch(msg.createdAt).minute.toString(),
    );

    message.animationController.forward();

    if (socket != null) {
      socket.emitWithAck("msg", [
        {
          "msg": msg.message,
          "author": currentUser.id,
          "reciever": otherId,
        },
      ]).then((data) {
        // this callback runs when this specific message is acknowledged by the server
        print("ACK recieved for $msg: $data");
      });
    }

    appDataBase.sendRecieveDirect(
        LocalMessage(
            message: msg.message,
            createdAt: msg.createdAt.toString(),
            isRead: true,
            isMine: true,
            receiverId: otherId,
            authorId: currentUser.id),
        true);
    this.add(MessageSentEvent(message));
  }

  Future<void> _showNotification(
      String title, String body, String payload) async {
    var androidPlatformChannelSpecifics = localLib.AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: localLib.Importance.Max,
        priority: localLib.Priority.High,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = localLib.IOSNotificationDetails();
    var platformChannelSpecifics = localLib.NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<void> _showMessagingNotification() async {
    // use a platform channel to resolve an Android drawable resource to a URI.
    // This is NOT part of the notifications plugin. Calls made over this channel is handled by the app
    String imageUri = await platform.invokeMethod('drawableToUri', 'food');
    var messages = List<localLib.Message>();
    // First two person objects will use icons that part of the Android app's drawable resources
    var me = localLib.Person(
        name: 'Me',
        key: '1',
        uri: 'tel:1234567890',
        icon: 'me',
        iconSource: localLib.IconSource.Drawable);
    var coworker = localLib.Person(
        name: 'Coworker',
        key: '2',
        uri: 'tel:9876543210',
        icon: 'coworker',
        iconSource: localLib.IconSource.Drawable);
    // download the icon that would be use for the lunch bot person
    // var largeIconPath = await _downloadAndSaveImage(
    //     'http://via.placeholder.com/48x48', 'largeIcon');
    // // this person object will use an icon that was downloaded
    // var lunchBot = Person(
    //     name: 'Lunch bot',
    //     key: 'bot',
    //     bot: true,
    //     icon: largeIconPath,
    //     iconSource: IconSource.FilePath);
    messages.add(localLib.Message('Hi', DateTime.now(), null));
    messages.add(localLib.Message(
        'What\'s up?', DateTime.now().add(Duration(minutes: 5)), coworker));
    messages.add(localLib.Message(
        'Lunch?', DateTime.now().add(Duration(minutes: 10)), null,
        dataMimeType: 'image/png', dataUri: imageUri));

    var messagingStyle = localLib.MessagingStyleInformation(me,
        groupConversation: true,
        conversationTitle: 'Team lunch',
        htmlFormatContent: true,
        htmlFormatTitle: true,
        messages: messages);
    var androidPlatformChannelSpecifics = localLib.AndroidNotificationDetails(
        'message channel id',
        'message channel name',
        'message channel description',
        style: localLib.AndroidNotificationStyle.Messaging,
        styleInformation: messagingStyle);
    var platformChannelSpecifics =
        localLib.NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        0, 'message title', 'message body', platformChannelSpecifics);

    // wait 10 seconds and add another message to simulate another response
    await Future.delayed(Duration(seconds: 10), () async {
      messages.add(localLib.Message(
          'Thai', DateTime.now().add(Duration(minutes: 11)), null));
      await flutterLocalNotificationsPlugin.show(
          0, 'message title', 'message body', platformChannelSpecifics);
    });
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
      this.add(Navigate(payload));
    }

    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SecondScreen(payload)),
    // );
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // await showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: title != null ? Text(title) : null,
    //     content: body != null ? Text(body) : null,
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }
}
