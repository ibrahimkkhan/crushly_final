import 'package:meta/meta.dart';

@immutable
abstract class ResetEvent {}

class SendEmail extends ResetEvent {
  final String email;
  SendEmail(this.email);
}

class SendOTP extends ResetEvent {
  final String otp, email;
  SendOTP(this.otp, this.email);
}

class SendNewPassword extends ResetEvent {
  final String email, otp, password;

  SendNewPassword(this.email, this.otp, this.password);
}

class ResendOTP extends ResetEvent {
  final String email;
  ResendOTP(this.email);
}
