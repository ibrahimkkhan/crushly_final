import 'dart:async';
import 'dart:core';

import '../resources//Api.dart';
import '../common/constants.dart';
import '../SharedPref/SharedPref.dart';
import '../models/Message.dart';
import '../models/Story.dart';
import '../models/User.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'AppDB.g.dart';

class LocalMessages extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get message => text()();

  TextColumn get createdAt => text()();

  BoolColumn get isMine => boolean().withDefault(Constant(false))();

  BoolColumn get isRead => boolean().withDefault(Constant(false))();

  TextColumn get receiverId => text().nullable()();

  TextColumn get authorId => text().nullable()();
}

class LocalStorys extends Table {
  IntColumn get localId => integer().autoIncrement()();

  TextColumn get id => text()();

  TextColumn get authorId => text()();

  TextColumn get url => text()();

  TextColumn get storyText => text()();

  TextColumn get authorName => text()();

  TextColumn get createdAt => text()();

  BoolColumn get private => boolean().withDefault(Constant(false))();
}

class StoryUsers extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  IntColumn get lastStory => integer().nullable()();
}

class LocalUsers extends Table {
  TextColumn get id => text()();

  TextColumn get name => text().nullable()();

  TextColumn get image => text().nullable()();

  TextColumn get nameBeforeReaveal => text().nullable()();

  BoolColumn get revealed => boolean().withDefault(Constant(false))();

  IntColumn get lastMessage => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  IntColumn get numOfUnRead => integer().nullable()();

  IntColumn get relation => integer().nullable()();

  BoolColumn get orginalySecret => boolean().withDefault(Constant(false))();

  BoolColumn get presentlySecret => boolean().withDefault(Constant(false))();

  BoolColumn get notify => boolean().withDefault(Constant(false))();
}

class BlockedUsers extends Table {
  TextColumn get id => text()();
}

class FolloweeUsers extends Table {
  TextColumn get id => text()();

  TextColumn get name => text().nullable()();

  TextColumn get nameBeforeReaveal => text().nullable()();

  TextColumn get thumbnail => text().nullable()();

  BoolColumn get revealed => boolean().withDefault(Constant(false))();

  BoolColumn get orginalySecret => boolean().withDefault(Constant(false))();

  BoolColumn get presentlySecret => boolean().withDefault(Constant(false))();

  BoolColumn get notify => boolean().withDefault(Constant(false))();
}

class DateUsers extends Table {
  TextColumn get partnerId => text()();

  TextColumn get name => text().nullable()();

  TextColumn get profilePhoto => text().nullable()();

  TextColumn get thumbnail => text().nullable()();

  BoolColumn get notify => boolean().withDefault(Constant(false))();
}

class Notifications extends Table {
  TextColumn get userName => text()();

  TextColumn get userId => text()();

  TextColumn get type => text()();

  TextColumn get image => text()();

  DateTimeColumn get createdAt => dateTime()();

  BoolColumn get seen => boolean().withDefault(Constant(false))();
}

class UserWithMessage {
  final LocalUser user;
  final LocalMessage message;

  UserWithMessage({
    @required this.message,
    @required this.user,
  });
}

class UserWithStory {
  final StoryUser user;
  final LocalStory story;

  UserWithStory({
    @required this.story,
    @required this.user,
  });
}

@UseMoor(tables: [
  LocalMessages,
  LocalUsers,
  FolloweeUsers,
  DateUsers,
  Notifications,
  LocalStorys,
  StoryUsers,
  BlockedUsers,
])
class AppDataBase extends _$AppDataBase {
  AppDataBase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db', logStatements: true));

  @override
  int get schemaVersion => 1;

  recieveRevealCollection(List<User> users) async {
    for (User u in users) {
      await revealIdetity(u.id, u.name, u.nickName, u.notify);
      if (u.notify != null) {
        if (u.notify) {
          newNotification(u, "reveal", u.createdAt);
        }
      }
    }
  }

  blockUsers(List<User> users) {
    for (User u in users) {
      into(blockedUsers).insert(
        BlockedUser(id: u.id),
      );
    }
  }

  blockUser(String userID) {
    into(blockedUsers).insert(BlockedUser(id: userID));
  }

  unBlockUser(String userID) {
    delete(blockedUsers)..where((user) => user.id.equals(userID));
  }

  Future<bool> isUserBlocked(String userID) async {
    final user = await (select(blockedUsers)
          ..where((user) => user.id.equals(userID)))
        .getSingle();
    // print('user is ${user.id}');
    return user != null;
  }

  recieveStoryCollection(List<Story> stories) async {
    try {
      for (Story s in stories) {
        LocalStory story = await (select(localStorys)
              ..where((story) => story.id.equals(s.id)))
            .getSingle();
        if (story == null) {
          final newStoryId = await into(localStorys).insert(LocalStory(
            id: s.id,
            authorId: s.author.id,
            authorName: s.author.name,
            url: s.url,
            storyText: s.text,
            createdAt: s.createdAt,
          ));

          final StoryUser storuser = await (select(storyUsers)
                ..where((user) => user.id.equals(s.author.id)))
              .getSingle();
          if (storuser != null) {
            await (update(storyUsers)..where((u) => u.id.equals(s.author.id)))
                .write(StoryUsersCompanion(
                    lastStory: Value(newStoryId),
                    updatedAt: Value(DateTime.now())));
          } else {
            //i f user not exist
            await into(storyUsers).insert(StoryUser(
                id: s.author.id,
                name: s.author.name,
                updatedAt: DateTime.now(),
                lastStory: newStoryId));
          }
        }
      }
    } catch (e) {}
  }

  Future<List<LocalStory>> getUserStories(String userId) {
    return ((select(localStorys)..where((s) => s.authorId.equals(userId)))
          ..orderBy([
            (s) =>
                (OrderingTerm(expression: s.createdAt, mode: OrderingMode.desc))
          ]))
        .get();
  }

  Stream<List<UserWithStory>> watchUserWithStories() {
    final query = (select(storyUsers).join([
      innerJoin(
          localStorys, localStorys.localId.equalsExp(storyUsers.lastStory))
    ])
      ..orderBy([
        (OrderingTerm(
            expression: storyUsers.updatedAt, mode: OrderingMode.desc))
      ]));
    return query.watch().map((rows) {
      return rows.map((row) {
        return UserWithStory(
          story: row.readTable(localStorys),
          user: row.readTable(storyUsers),
        );
      }).toList();
    });
  }

  revealIdetity(
      String userId, String newName, String oldName, bool notify) async {
    await (update(localUsers)..where((u) => u.id.equals(userId))).write(
      LocalUsersCompanion(
          revealed: Value(true),
          nameBeforeReaveal: Value(oldName),
          name: Value(newName),
          presentlySecret: Value(false),
          notify: Value(notify)),
    );
    await (update(followeeUsers)..where((u) => u.id.equals(userId))).write(
        FolloweeUsersCompanion(
            revealed: Value(true),
            nameBeforeReaveal: Value(oldName),
            name: Value(newName),
            presentlySecret: Value(false),
            notify: Value(notify)));
  }

  //recive all messages when not in the chat page
  recieveUnread(LocalMessage message) async {
    LocalUser user = await (select(localUsers)
          ..where((u) => u.id.equals(message.authorId)))
        .getSingle();
    if (user != null) {
      //user exist in db as it should be else he should be in followers list

      final lastMessageId = await into(localMessages).insert(message);
      final LocalUser user = await (select(localUsers)
            ..where((u) => u.id.equals(message.authorId)))
          .getSingle();

      final int num = user.numOfUnRead == null ? 1 : user.numOfUnRead + 1;

      await (update(localUsers)..where((u) => u.id.equals(user.id))).write(
          LocalUsersCompanion(
              lastMessage: Value(lastMessageId),
              numOfUnRead: Value(num),
              updatedAt: Value(DateTime.now())));
    } else {
      //user is in followers list
      final lastMessageId = await into(localMessages).insert(message);
      final LocalUser localUser = await (select(localUsers)
            ..where((u) => u.id.equals(message.authorId)))
          .getSingle();

      final int num = localUser == null
          ? 1
          : localUser.numOfUnRead == null ? 1 : localUser.numOfUnRead + 1;
      final user = await Api.apiClient.relationWithOtherUser(message.authorId);
      await addToLocalUsersIfUpsent(
        LocalUser(
          id: user.id,
          numOfUnRead: num,
          lastMessage: lastMessageId,
          orginalySecret: user.orignallySecret,
          name: user.name,
          nameBeforeReaveal: user.name,
          relation: user.relation,
          image: user.thumbnail,
          presentlySecret: user.presentlySecret,
          notify: false,
        ),
      );
    }
  }

  recieveCollectionUnread(List<Message> messages) async {
    for (Message m in messages) {
      print("message author id is ${m.author}");
      await recieveUnread(LocalMessage(
          message: m.message,
          createdAt: m.createdAt.toString(),
          isRead: false,
          isMine: false,
          authorId: m.author,
          receiverId: m.reciever));
    }
  }

  Future<bool> checkIfLocalUserAbsent(String userID) async {
    print('checkIfLocalUserAbsent $userID');
    final LocalUser user = await (select(localUsers)
          ..where((u) => u.id.equals(userID)))
        .getSingle();
    return user == null;
  }

  addToLocalUsersIfUpsent(LocalUser localUser) async {
    final LocalUser user = await (select(localUsers)
          ..where((u) => u.id.equals(localUser.id)))
        .getSingle();
    if (user == null) {
      await into(localUsers).insert(LocalUser(
          id: localUser.id,
          name: localUser.name,
          image: localUser.image,
          lastMessage: localUser.lastMessage ?? -1,
          updatedAt: DateTime.now(),
          relation: localUser.relation,
          numOfUnRead: localUser.numOfUnRead,
          orginalySecret: localUser.orginalySecret,
          presentlySecret:
              localUser.presentlySecret ?? localUser.orginalySecret));
    }
  }

  recieveFolloweeCollection(List<User> users) async {
//    for (User u in users) {
//      await into(followeeUsers).insert(FolloweeUser(
//          id: u.id,
//          name: u.name,
//          orginalySecret: u.orignallySecret,
//          presentlySecret: u.presentlySecret ?? u.orignallySecret));
//      addToLocalUsersIfUpsent(LocalUser(
//          id: u.id,
//          name: u.name,
//          orginalySecret: u.orignallySecret,
//          presentlySecret: u.presentlySecret ?? u.orignallySecret));
//
//      if (u.notify != null) {
//        if (u.notify) {
//          newNotification(u, "followee", u.createdAt);
//        }
//      }
//    }
  }

  receiveNotifications(List<User> users, String type) async {
    for (User u in users) {
//      addToLocalUsersIfUpsent(LocalUser(
//          id: u.id,
//          name: u.name,
//          orginalySecret: u.orignallySecret,
//          presentlySecret: u.presentlySecret ?? u.orignallySecret));
      if (u.notify != null) {
        if (u.notify) {
          switch (type) {
            case 'followee':
              newNotification(
                  u, u.orignallySecret ? "followee" : "secret", u.createdAt);
              break;
            case 'reveal':
              newNotification(u, "reveal", u.createdAt);
              break;
            case 'date':
              newNotification(u, "date", u.createdAt);
              break;
          }
        }
      }
    }
  }

  newNotification(User user, String type, DateTime createdAt) async {
    print('current date is $createdAt');
    await into(notifications).insert(Notification(
        userName: user.name,
        createdAt: createdAt,
        userId: user.id,
        type: type,
        seen: false,
        image: user.thumbnail));
  }

  Future<List<Notification>> getAllNotifications() async {
    return await (select(notifications)
          ..orderBy([
            (u) => OrderingTerm(expression: u.userId, mode: OrderingMode.desc)
          ]))
        .get();
  }

  setAllNotificationSeen() {
    update(notifications).write(NotificationsCompanion(seen: Value(true)));
  }

  recieveDateCollection(List<User> users) async {
//    for (User u in users) {
//      await into(dateUsers).insert(DateUser(
//          partnerId: u.id,
//          name: u.name,
//          notify: u.notify,
//          profilePhoto: u.profilePhoto));
//      addToLocalUsersIfUpsent(LocalUser(
//          id: u.id,
//          name: u.name,
//          orginalySecret: u.orignallySecret,
//          presentlySecret: u.presentlySecret ?? u.orignallySecret));
//      newNotification(u, "date", u.createdAt);
//    }
  }

  recieveDateUser(User user) async {
//    await into(dateUsers).insert(DateUser(
//        partnerId: user.id,
//        name: user.name,
//        notify: user.notify,
//        profilePhoto: user.profilePhoto));
//    addToLocalUsersIfUpsent(LocalUser(
//        id: user.id,
//        name: user.name,
//        orginalySecret: user.orignallySecret,
//        presentlySecret: user.presentlySecret ?? user.orignallySecret));
  }

  recieveFolloweeUser(User user) async {
//    await into(followeeUsers).insert(FolloweeUser(
//        id: user.id,
//        name: user.name,
//        orginalySecret: user.orignallySecret,
//        presentlySecret: user.presentlySecret ?? user.orignallySecret));
//    addToLocalUsersIfUpsent(LocalUser(
//        id: user.id,
//        name: user.name,
//        orginalySecret: user.orignallySecret,
//        presentlySecret: user.presentlySecret ?? user.orignallySecret));
  }

  Future<List<FolloweeUser>> getFollowee() {
    return (select(followeeUsers)).get();
  }

  Future<List<DateUser>> getDates() {
    return (select(dateUsers)).get();
  }

  clearNewMessageNum(String userId) {
    (update(localUsers)..where((user) => user.id.equals(userId)))
        .write(LocalUsersCompanion(
      numOfUnRead: Value(0),
    ));
  }

  revealMyIdentity(String userId) {
    (update(localUsers)..where((user) => user.id.equals(userId)))
        .write(LocalUsersCompanion(
      relation: Value(Relations.CRUSHEE),
    ));
  }

  sendRecieveDirect(LocalMessage message, bool isMine, bool isRead) async {
    final lastMessageId = await into(localMessages).insert(message);

    bool isAbsent = await checkIfLocalUserAbsent(
        isMine ? message.receiverId : message.authorId);
    print('is Absent = $isAbsent');
    if (!isAbsent) {
      await (update(localUsers)
            ..where((user) =>
                user.id.equals(isMine ? message.receiverId : message.authorId)))
          .write(LocalUsersCompanion(
              lastMessage: Value(lastMessageId),
              updatedAt: Value(DateTime.now())));
    } else {
      final user = await Api.apiClient.relationWithOtherUser(
          isMine ? message.receiverId : message.authorId);
      await addToLocalUsersIfUpsent(
        LocalUser(
          lastMessage: lastMessageId,
          id: user.id,
          orginalySecret: user.orignallySecret,
          name: user.name,
          relation: user.relation,
          nameBeforeReaveal: user.name,
          numOfUnRead: isRead ? 0 : 1,
          image: user.thumbnail,
          presentlySecret: user.presentlySecret,
          notify: false,
        ),
      );
    }
  }

  Future<int> getUserRelation(String id) async {
    final localUser = await (select(localUsers)
          ..where((m) {
            return m.id.equals(id);
          }))
        .getSingle();
    if (localUser != null) return localUser.relation;
    return null;
  }

  Future<List<LocalMessage>> getMessages(String id) {
    //for one person by the time
    return (select(localMessages)
          ..where((m) {
            return or(m.authorId.equals(id), m.receiverId.equals(id));
          }))
        .get();
  }

  Stream<List<UserWithMessage>> watchUserWithMessages() {
    final query = (select(localUsers).join([
      innerJoin(
          localMessages, localMessages.id.equalsExp(localUsers.lastMessage))
    ])
      ..orderBy([
        (OrderingTerm(
            expression: localUsers.updatedAt, mode: OrderingMode.desc))
      ]));
    return query.watch().map((rows) {
      return rows.map((row) {
        return UserWithMessage(
          message: row.readTable(localMessages),
          user: row.readTable(localUsers),
        );
      }).toList();
    });
  }

  Stream<bool> isThereAnyUnreadMessages() {
    final result = (select(localUsers)
      ..where((user) {
        return user.numOfUnRead.isBiggerThanValue(0);
      }));
    return result.watch().map((rows) {
      return rows.length > 0;
    });
  }

  Stream<bool> isThereAnyUnseenNotifications() {
    final result = (select(notifications)
      ..where((notification) {
        return notification.seen.equals(false);
      }));
    return result.watch().map((rows) {
      return rows.length > 0;
    });
  }

  clearDB() {
    delete(localMessages).go();
    delete(localUsers).go();
    delete(followeeUsers).go();
    delete(dateUsers).go();
    delete(notifications).go();
    delete(localStorys).go();
    delete(storyUsers).go();
  }
}
