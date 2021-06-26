import 'package:meta/meta.dart';

abstract class ResetState {}

class InitialState extends ResetState {}

class CurrentState extends ResetState {
  final bool success, loading, resendOTP;
  final String error;
  final bool forgotPasswordSuccess;

  CurrentState({
    this.resendOTP,
    this.loading,
    this.success,
    this.error,
    this.forgotPasswordSuccess = false,
  });
}
