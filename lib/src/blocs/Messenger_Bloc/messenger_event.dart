import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';
import 'package:crushly/Screens/Chat_Page.dart';
import 'package:crushly/models/Message.dart';

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

class MessageSentEvent extends MassengerEvent {
  final MessageWidget message;
  MessageSentEvent(this.message);
}

class SendEvent extends MassengerEvent {
  final Message msg;

  final String otherId;
  SendEvent(this.msg, this.otherId);
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
class TextEvent extends MassengerEvent{}