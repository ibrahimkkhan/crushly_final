import '../../blocs/Massenger_Bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../screens/Chat_Page.dart';

@immutable
abstract class MassengerState {}

class InitialMassengerState extends MassengerState {}

class Connected extends MassengerState {}

class LocalMessagesReady extends MassengerState {
  final List<MessageWidget> messages;
  final int relation;

  LocalMessagesReady(this.messages, this.relation);
}

class NotConnected extends MassengerState {
  final String error;
  NotConnected(this.error);
}

class LoadingConnect extends MassengerState {}

class LoadingLocalMessages extends MassengerState {}

class MessagesBox extends MassengerState {
  final List<MessageWidget> messages;

  MessagesBox(this.messages);
}

class LogedOut extends MassengerState {}

class SuspendApp extends MassengerState {}

class RevealCurrentChatUser extends MassengerState {
  final String newName;
  RevealCurrentChatUser(this.newName);
}

class NavigateState extends MassengerState {
  final String payload;
  NavigateState(this.payload);
}
