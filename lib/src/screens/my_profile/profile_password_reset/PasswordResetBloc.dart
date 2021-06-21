import 'package:bloc/bloc.dart';
import 'package:crushly/Api/Api.dart';
import 'package:crushly/Screens/my_profile/profile_password_reset/PasswordResetEvent.dart';
import 'package:crushly/Screens/my_profile/profile_password_reset/PasswordResetState.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  @override // TODO: implement initialState
  PasswordResetState get initialState => InitialState();

  @override
  Stream<PasswordResetState> mapEventToState(PasswordResetEvent event) async* {
    if (event is PasswordResetSended) {
      yield* resetPasswordToMap(event.oldPassword, event.newPassword);
    }
  }

  Stream<PasswordResetState> resetPasswordToMap(
      oldPassword, newPassword) async* {
    yield InitialState();
    yield CurrentState(
        isLoading: true, isSuccess: false, isFail: false, error: "");
    try {
      int response =
          await Api.apiClient.passwordReset(oldPassword, newPassword);

      if (response == 200) {
        yield CurrentState(
          isLoading: false,
          isSuccess: true,
          isFail: false,
          error: "",
        );
      } else {
        yield CurrentState(
            isLoading: false,
            isSuccess: false,
            isFail: true,
            error: "Your Current Password is incorrect");
      }
    } catch (e) {
      yield CurrentState(
          isLoading: false, isSuccess: false, isFail: true, error: "Catch");
    }
  }
}
