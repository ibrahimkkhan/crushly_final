import 'package:meta/meta.dart';

@immutable
abstract class PasswordResetEvent {}

class PasswordResetSended extends PasswordResetEvent {
  final String oldPassword, newPassword;

  PasswordResetSended({required this.newPassword, required this.oldPassword});
}
