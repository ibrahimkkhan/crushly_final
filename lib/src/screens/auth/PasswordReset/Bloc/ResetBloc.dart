import 'package:bloc/bloc.dart';
import 'package:crushly/Api/Api.dart';
import 'package:crushly/Screens/auth/PasswordReset/Bloc/ResetEvent.dart';
import 'package:crushly/Screens/auth/PasswordReset/Bloc/ResetState.dart';
import 'package:crushly/SharedPref/SharedPref.dart';
import 'package:crushly/models/User.dart';

class ResetBloc extends Bloc<ResetEvent, ResetState> {
  @override
  ResetState get initialState => InitialState();

  @override
  Stream<ResetState> mapEventToState(ResetEvent event) async* {
    if (event is ResendOTP) {
      yield* resendOTP(event.email);
    }
    if (event is SendEmail) {
      yield* sendEmailToMap(event.email);
    }
    if (event is SendOTP) {
      yield* sendOTPToMap(event.otp, event.email);
    }
    if (event is SendNewPassword) {
      yield* setPasswordToMap(event.email, event.otp, event.password);
    }
  }

  Stream<ResetState> sendEmailToMap(email) async* {
    yield CurrentState(loading: true, success: false);
    try {
      int response = await Api.apiClient.postResetEmailCheck(email);
      if (response == 200) {
        yield CurrentState(
          loading: false,
          success: true,
        );
      } else {
        yield CurrentState(
            loading: false, success: false, error: "Email doesnt exits");
      }
    } catch (e) {
      yield CurrentState(loading: false, success: false, error: e);
    }
  }

  Stream<ResetState> resendOTP(email) async* {
    yield CurrentState(loading: true, success: false, resendOTP: false);
    try {
      int response = await Api.apiClient.postResetEmailCheck(email);
      if (response == 200) {
        yield CurrentState(loading: false, success: false, resendOTP: true);
      } else {
        yield CurrentState(
            loading: false,
            success: false,
            resendOTP: false,
            error: "OTP resend failed");
      }
    } catch (e) {
      yield CurrentState(
          loading: false, success: false, error: e, resendOTP: false);
    }
  }

  Stream<ResetState> sendOTPToMap(otp, email) async* {
    yield CurrentState(loading: true, success: false);
    try {
      int response = await Api.apiClient.postOTP(otp, email);
      if (response == 200) {
        yield CurrentState(
          loading: false,
          success: true,
        );
      } else {
        yield CurrentState(
            loading: false,
            success: false,
            error: "The code you entered is incorrect");
      }
    } catch (e) {
      yield CurrentState(loading: false, success: false, error: e);
    }
  }

  Stream<ResetState> setPasswordToMap(email, otp, password) async* {
    yield CurrentState(loading: true, success: false);
    try {
      User user = await Api.apiClient.postSetNewPassword(email, otp, password);
      if (user != null) {
        await SharedPref.pref.saveUser(user);
        yield CurrentState(
          forgotPasswordSuccess: true,
          loading: false,
          success: true,
        );
      } else {
        yield CurrentState(
          loading: false,
          success: false,
        );
      }
    } catch (e) {
      yield CurrentState(loading: false, success: false, error: e);
    }
  }
}
