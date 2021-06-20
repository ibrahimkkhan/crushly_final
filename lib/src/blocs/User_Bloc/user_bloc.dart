import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../resources/Api.dart';
import '../../db/AppDB.dart';
import '../../SharedPref/SharedPref.dart';
import '../../models/BaseOtherUser.dart';
import '../../models/User.dart';
import '../../models/follow_response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AppDataBase appDataBase;

  UserBloc(this.appDataBase) : super(InitialUserState());

  @override
  UserState get initialState => InitialUserState();
  late String userID;
  List<User> followList = [];

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetNotification) {
      yield LoadingNotification();
      late List<Notification> notifications;
      await appDataBase.getAllNotifications().then((onValue) {
        notifications = onValue;
      });
      yield NotificationReady(notifications);
    }
    if (event is RevealIdentity) {
      try {
        yield LoadingReveal();

        final isRevealed = await Api.apiClient.reveal(event.userID);
        if (isRevealed != null && isRevealed) {
          appDataBase.revealMyIdentity(event.userID);
          yield RevealIdentitySuccess();
//          followList = user.followList ?? [];
//          yield fetchSuccefully(user);
//          appDataBase.recieveStoryCollection(user.myfeed ?? []);
//          appDataBase.updateAllFollowers(user["person"].followList,
//          user["myfollowees"], user["person"].dateList);
        } else {
          yield RevealIdentityError();
        }
      } catch (e) {
        yield RevealIdentityError();
      }
    }

    if (event is GetIfUserBlocked) {
      final isBlocked = await appDataBase.isUserBlocked(event.userID);
      if (isBlocked) yield BlockSuccess();
    }

    if (event is BlockUserEvent) {
      try {
        yield LoadingBlock();

        final isBlocked = await Api.apiClient.blockUser(event.userID);
        if (isBlocked != null && isBlocked) {
          appDataBase.blockUser(event.userID);
          yield BlockSuccess();
//          followList = user.followList ?? [];
//          yield fetchSuccefully(user);
//          appDataBase.recieveStoryCollection(user.myfeed ?? []);
//          appDataBase.updateAllFollowers(user["person"].followList,
//          user["myfollowees"], user["person"].dateList);
        } else {
          yield BlockError();
        }
      } catch (e) {
        yield BlockError();
      }
    }

    if (event is UnBlockUserEvent) {
      try {
        yield LoadingBlock();

        final isUnblocked = await Api.apiClient.unBlock(event.userID);
        if (isUnblocked != null && isUnblocked) {
          appDataBase.unBlockUser(event.userID);
          yield UnBlockSuccess();
//          followList = user.followList ?? [];
//          yield fetchSuccefully(user);
//          appDataBase.recieveStoryCollection(user.myfeed ?? []);
//          appDataBase.updateAllFollowers(user["person"].followList,
//          user["myfollowees"], user["person"].dateList);
        } else {
          yield UnBlockError();
        }
      } catch (e) {
        yield UnBlockError();
      }
    }

    if (event is FetchUser) {
      try {
        yield LoadingFetch();
        await SharedPref.pref.getUser().then((user) {
          userID = user.id;
        });
        yield fetchSuccefully(User(id: userID));
        late User user;
        String error;

        await Api.apiClient.fetchUser(userID).then((onValue) {
          user = onValue;
        }).catchError((onError) {
          error = onError;
        });
        if (user != null) {
          followList = user.followList ?? [];
//          yield fetchSuccefully(user);
          appDataBase.recieveStoryCollection(user.myfeed ?? []);
          // appDataBase.updateAllFollowers(user["person"].followList,
          //     user["myfollowees"], user["person"].dateList);
        } else {
//          yield fetchFailed(error);
        }
      } catch (e) {}
    }
    if (event is UpdateProfile) {
      late User user;
      late String error;
      await Api.apiClient.fetchUser(userID).then((onValue) {
        user = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (user != null) {
        followList = user.followList!;
        yield fetchSuccefully(user);
        // appDataBase.updateAllFollowers(user["person"].followList,
        //     user["myfollowees"], user["person"].dateList);
        appDataBase.recieveStoryCollection(user.myfeed!);
      } else {
        yield fetchFailed(error);
      }
    }
    if (event is NewUser) {
      yield LoadingFetch();
      late String token;
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
      // _firebaseMessaging.configure(
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

      await _firebaseMessaging.getAPNSToken().then((t) {
        assert(t != null);

        token = t!;
      });
      late User user;
      late String error;
     await Api.apiClient.newUser(firstName:event.name,token: token).then((onValue) {
       user = onValue;
     }).catchError((onError) {
       error = onError;
     });
      if (user != null) {
        await SharedPref.pref.saveUser(user);
        yield AddUserSuccess(user);
      } else {
        yield AddUserFailed(error);
      }
    }
    if (event is FetchOtherUser) {
      yield LoadingFetchOther();
      late String error;
      late BaseOtherUser data;
      await Api.apiClient.fetchOtherUser(event.id).then((onValue) {
        data = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (data != null) {
        yield FetchOtherSuccess(data);
      } else {
        yield FetchOtherFailed(error);
      }
    }
    if (event is UpdateOtherProfile) {
      late String error;
      late BaseOtherUser data;
      await Api.apiClient.fetchOtherUser(event.id).then((onValue) {
        data = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (data != null) {
        yield FetchOtherSuccess(data);
        this.add(UpdateProfile());
      } else {
        yield FetchOtherFailed(error);
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
      await Api.apiClient.logout();
      appDataBase.clearDB();
      SharedPref.pref.daleteUser();
    }
    if (event is Follow) {
      yield LoadingFollow(event.isSecret);
      late FollowResponse followResponse;
      late String error;
      await Api.apiClient
          .follow(userID, event.otherId, event.isSecret ? 'true' : 'false')
          .then((onValue) async {
        followResponse = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (followResponse != null) {
        if (followResponse.isDate ?? false) {
          if (followResponse.otherHadSecret) {
            appDataBase.revealIdetity(
                event.otherId,
                followResponse.otherName,
                "nickName",
                followResponse.isDate ??
                    false); //! the old name must be replaced here
          }
//          appDataBase.recieveDateUser(
//              User(id: event.otherId, name: event.otherName, notify: false));
        }
        yield FollowedSuccessfully(
            followResponse, event.otherId, event.isSecret);
//        this.add(UpdateOtherProfile(userID, event.otherId));
      } else {
        yield ErrorInFollowing(error);
      }
    }
  }
}
