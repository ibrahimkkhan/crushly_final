import 'package:meta/meta.dart';

abstract class PasswordResetState {}

class InitialState extends PasswordResetState {}

class CurrentState extends PasswordResetState {
  final bool isOldPasswordCorrect, isSuccess, isFail, isLoading;
  final String error;

  CurrentState({
    this.error,
    this.isSuccess,
    this.isLoading,
    this.isFail,
    this.isOldPasswordCorrect,
  });
}
