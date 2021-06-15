import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../Api/Api.dart';
import '../../DB/AppDB.dart';
import '../../SharedPref/SharedPref.dart';
import '../../models/User.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  String userID;
  final AppDataBase appDataBase;
  UserBloc(this.appDataBase, this.userID) : super(InitialUserState());
  @override
  UserState get initialState => InitialUserState();
  List<User> followList = [];
  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetNotification) {
      yield LoadingNotification();
      List<Notification>? notifications;
      await appDataBase.getAllNotifications().then((onValue) {
        notifications = onValue;
      });
      yield NotificationReady(notifications!);
    }
    if (event is FetchUser) {
      yield LoadingFetch();
      await SharedPref.pref.getUser().then((user) {
        userID = user.id;
      });
      Map<String, dynamic>? user;
      String? error;
      await Api.apiClient.fetchUser(userID).then((onValue) {
        user = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (user != null) {
        followList = user!["person"].followList;
        yield fetchSuccefully(user!);
        appDataBase.recieveStoryCollection(user!["person"].myfeed);
        // appDataBase.updateAllFollowers(user["person"].followList,
        //     user["myfollowees"], user["person"].dateList);
      } else {
        yield fetchFailed(error!);
      }
    }
    if (event is UpdateProfile) {
      Map<String, dynamic>? user;
      String? error;
      await Api.apiClient.fetchUser(userID).then((onValue) {
        user = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (user != null) {
        followList = user!["person"].followList;
        yield fetchSuccefully(user!);
        // appDataBase.updateAllFollowers(user["person"].followList,
        //     user["myfollowees"], user["person"].dateList);
        appDataBase.recieveStoryCollection(user!["person"].myfeed);
      } else {
        yield fetchFailed(error!);
      }
    }
    if (event is NewUser) {
      yield LoadingFetch();
      String? token;
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message data: ${message.data}');
        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification}');
        }
      });
      // _firebaseMessaging.getNotificationSettings(
      //   onMessage: (Map<String, dynamic> message) async {
      //     print("onMessage: $message");
      //   },
      //   onLaunch: (Map<String, dynamic> message) async {
      //     print("onLaunch: $message");
      //   },
      //   onResume: (Map<String, dynamic> message) async {
      //     print("onResume: $message");
      //   },
      // );

      await _firebaseMessaging.getToken().then((String? t) {
        assert(t != null);

        token = t!;
      });
      Map<String, dynamic>? user;
      String? error;
      await Api.apiClient.newUser(event.name, token!).then((onValue) {
        user = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (user != null) {
        await SharedPref.pref.saveUser(user!["person"]);
        yield AddUserSuccess(user!);
      } else {
        yield AddUserFailed(error!);
      }
    }
    if (event is FetchOtherUser) {
      yield LoadingFetchOther();
      String? error;
      Map<String, dynamic>? data;
      await Api.apiClient.fetchOtherUser(event.myId, event.id).then((onValue) {
        data = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (data != null) {
        yield FetchOtherSuccess(data!);
      } else {
        yield FetchOtherFailed(error!);
      }
    }
    if (event is UpdateOtherProfile) {
      String? error;
      Map<String, dynamic>? data;
      await Api.apiClient.fetchOtherUser(event.myId, event.id).then((onValue) {
        data = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (data != null) {
        yield FetchOtherSuccess(data!);
        this.add(UpdateProfile());
      } else {
        yield FetchOtherFailed(error!);
      }
    }
    if (event is GetFollowee) {
      final List<FolloweeUser> followees = await appDataBase.getFollowee();
      yield FolloweeReady(followees);
    }
    if (event is GetDates) {
      final List<DateUser> dates = await appDataBase.getDates();
      yield DatesReady(dates);
    }
    if (event is Logout) {
      appDataBase.clearDB();
      SharedPref.pref.daleteUser();
    }
    if (event is Follow) {
      yield LoadingFollow();
      Map<String, dynamic>? result;
      String? error;
      await Api.apiClient
          .follow(userID, event.otherId, event.isSecret ? "true" : "false")
          .then((onValue) {
        result = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (result != null) {
        if (result!["isDate"]) {
          if (result!["otherHadSecret"]) {
            appDataBase.revealIdetity(
                event.otherId,
                result!["newName"],
                "nickName",
                result!["notify"] ??
                    false); //! the old name must be replaced here
          }
          appDataBase.recieveDateUser(
              User(id: event.otherId, name: event.otherName, notify: false));
        }
        yield FollowedSuccessfuly(result!["isDate"]);
        this.add(UpdateOtherProfile(userID, event.otherId));
      } else {
        yield ErrorInFollowing(error!);
      }
    }
  }
}
