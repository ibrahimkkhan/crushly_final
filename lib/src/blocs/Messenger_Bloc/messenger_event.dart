import '../../Screens/Chat_Page.dart';
import '../../models/Message.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MassengerEvent {}

class Connect extends MassengerEvent {}

class ConnectedEvent extends MassengerEvent {}

class NotConnectedEvent extends MassengerEvent {
  final String error;

  NotConnectedEvent(this.error);
}

class NewMessageEvent extends MassengerEvent {
  final Message msg;

  NewMessageEvent(this.msg);
}

class BlockedUserEvent extends MassengerEvent {}

class MessageSentEvent extends MassengerEvent {
  final MessageWidget message;

  MessageSentEvent(this.message);
}

class SendEvent extends MassengerEvent {
  final Message msg;

  SendEvent(this.msg);
}

class EnterConversation extends MassengerEvent {
  final TickerProvider ticker;
  final String otherId;
  final String name;

  EnterConversation(this.otherId, this.name, this.ticker);
}

class LoadList extends MassengerEvent {}

class LogoutEvent extends MassengerEvent {}

class SuspendAppEvent extends MassengerEvent {}

class RefreashChat extends MassengerEvent {}

class Navigate extends MassengerEvent {
  final String payload;

  Navigate(this.payload);
}

class RevealEventForChat extends MassengerEvent {
  final String newName;

  RevealEventForChat(this.newName);
}

class TextEvent extends MassengerEvent {}
