import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../resources/Api.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../SharedPref/SharedPref.dart';
import '../../models/University.dart';
import '../../models/User.dart';
import '../../models/upload_photo.dart';
import '../../utils/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String email = '';
  String gender = '';
  String lastName = '';
  String password = '';
  String birthDate = '';
  String firstName = '';
  University schoolName = University();
  String greekHouse = '';
  String interestedGender = '';
  int primaryPhotoIndex = 0;
  late Position position;
  List<Asset> photos = [];

  AuthBloc(AuthState initialState) : super(AuthInitialState());

  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    print('AuthBloc => mapEventToState => event = ${event.toString()}');
    if (event is EmailChanged) {
      email = event.email;
      final emailValidation =
          event.email.contains('@') && event.email.contains('.edu');

      add(ResetEmailAvailable());

      if (state is SignInState) {
        final signInState = state as SignInState;
        yield signInState.rebuild((b) => b
          ..emailValidation = emailValidation
          ..signInValidation =
              emailValidation && signInState.passwordValidation);
      } else {
        final signUpState = state as SignUpState;
        yield signUpState.rebuild((b) => b
          ..emailValidation = emailValidation
          ..signUpValidation =
              emailValidation && signUpState.passwordValidation);
      }
    } else if (event is PasswordChanged) {
      password = event.password;
      final passwordValidation = password.length >= 6;

      if (state is SignInState) {
        final signInState = state as SignInState;
        yield signInState.rebuild((b) => b
          ..passwordValidation = passwordValidation
          ..signInValidation =
              passwordValidation && signInState.emailValidation);
      } else {
        final signUnState = state as SignUpState;
        yield signUnState.rebuild((b) => b
          ..passwordValidation = passwordValidation
          ..signUpValidation =
              passwordValidation && signUnState.emailValidation);
      }
    } else if (event is ResetSignInError)
      yield SignInState.initial();
    else if (event is ResetSignUpError)
      yield SignUpState.initial();
    else if (event is LoginInitiated)
      yield* mapLoginInitiated(event, state as SignInState);
    else if (event is SignUpInitiated)
      yield* mapSignUpInitiated(event, state as SignUpState);
    else if (event is GetLocation)
      yield* mapGetLocation(event);
    else if (event is GetSignInInitialState)
      yield SignInState.initial();
    else if (event is GetSignUpInitialState)
      yield SignUpState.initial();
    else if (event is GetLocationInitialState)
      yield LocationState.initial();
    else if (event is CheckEmail)
      yield* mapCheckEmail(event);
    else if (event is ResetEmailAvailable) {
      final currentState = state as SignUpState;
      yield currentState.rebuild((b) => b
        ..isEmailAvailable = null
        ..signUpSuccessfully = false);
    } else if (event is UploadImages) {
      final currentState = state as SignUpState;
      yield* mapUploadImagesInitiated(event, currentState);
    }
  }

  Stream<AuthState> mapCheckEmail(CheckEmail event) async* {
    final currentState = state as SignUpState;
    try {
      yield currentState.rebuild((b) => b..signingUp = true);
      final isAvailable = await Api.apiClient.checkIfEmailExists(event.email);
      print('AuthBloc => mapCheckEmail => email avaible => = $isAvailable');
      yield currentState.rebuild((b) => b
        ..isEmailAvailable = isAvailable
        ..signingUp = false);
    } catch (e) {
      print('AuthBloc => mapCheckEmail => ERROR = $e');
      yield currentState.rebuild((b) => b
        ..isEmailAvailable = false
        ..signingUp = false);
    }
  }

  Stream<AuthState> mapGetLocation(GetLocation event) async* {
    try {
      yield LocationState.initial().rebuild((b) => b..acquiringLocation = true);
      final status = await Permission.location.request();
      print('status is $status');
      yield LocationState.initial().rebuild((b) => b
        ..acquiringLocation = false
        ..errorGettingLocation = false
        ..locationAcquiredSuccessfully = true);
      if (status.isGranted) {
        yield LocationState.initial().rebuild((b) => b
          ..acquiringLocation = false
          ..errorGettingLocation = false
          ..locationAcquiredSuccessfully = true);
//        position = await Geolocator()
//            .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      }
      print('AuthBloc => mapGetLocation => Location = $position');

      if (position != null)
        yield LocationState.initial().rebuild((b) => b
          ..acquiringLocation = false
          ..errorGettingLocation = false
          ..locationAcquiredSuccessfully = true);
      else
        yield LocationState.initial().rebuild((b) => b
          ..acquiringLocation = false
          ..errorGettingLocation = true
          ..locationAcquiredSuccessfully = false);
    } catch (e) {
      print('AuthBloc => mapGetLocation => ERROR = $e');
      yield LocationState.initial().rebuild((b) => b
        ..acquiringLocation = false
        ..errorGettingLocation = true
        ..locationAcquiredSuccessfully = false);
    }
  }

  Stream<AuthState> mapLoginInitiated(
      LoginInitiated event, SignInState state) async* {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        yield state.rebuild((b) => b..signingIn = true);
        String token;
        final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
        // _firebaseMessaging.configure(
        //   onMessage: (Map<String, dynamic> message) async {
        //     print("onMessage: $message");
        //   },
        //   onLaunch: (Map<String, dynamic> message) async {
        //     print("onLaunch: $message");
        //   },
        //   onResume: (Map<String, dynamic> message) async {
        //     print("onResume: $message");
        //   },
        // );
        token = (await _firebaseMessaging.getAPNSToken())!;
        User user;
        user = await Api.apiClient.loginUser(
          email: email,
          password: password,
          token: token,
        );
        if (user != null) {
          await SharedPref.pref.saveUser(user);
          await SharedPref.pref.setImagesUploaded();
          await SharedPref.pref.setIntroShown(false);
          isFromLogin = true;
          yield state.rebuild((b) => b
            ..signInSuccessfully = true
            ..signingIn = true);
        } else {
          isFromLogin = false;
          yield state.rebuild((b) => b
            ..signingIn = false
            ..signInSuccessfully = false
            ..signInError = ERROR_GETTING_DATA);
        }
      } catch (e) {
        print('AuthBloc => mapLoginInitiated => ERROR = $e');
        yield state.rebuild((b) => b
          ..signingIn = false
          ..signInSuccessfully = false
          ..signInError = ERROR_GETTING_DATA);
      }
    }
  }

  Stream<AuthState> mapUploadImagesInitiated(
      UploadImages event, SignUpState state) async* {
    try {
      yield state.rebuild((b) => b..signingUp = true);
      List<UploadPhoto> images = [];
      for (int i = 0; i < photos.length; i++) {
        //For right file path =>
        /* File image = File(photos[i].path.substring(0, 19) +
            "/Android/data/com.asyncstates.crushly/files/Pictures/" +
            photos[i].path.substring(20, photos[i].path.length));*/

        images.add(UploadPhoto(photos[i], i));
      }
      // await SharedPref.pref.setIntroShown(false);
      // final result = await Api.apiClient.setPhotos(images);
      Api.apiClient.setPhotos(images);
      // await SharedPref.pref.setImagesUploaded();
      // if (result.isNotEmpty) {
      //   yield state.rebuild((b) => b
      //     ..signingUp = false
      //     ..uploadPhotoSuccessfully = true);
      // }
      yield state.rebuild((b) => b
        ..signingUp = false
        ..uploadPhotoSuccessfully = true);
    } catch (e) {
      print('AuthBloc => mapUploadImagesInitiated => ERROR = $e');
      yield state.rebuild((b) => b
        ..signingUp = false
        ..uploadPhotoSuccessfully = false
        ..signUpError = ERROR_GETTING_DATA);
    }
  }

  Stream<AuthState> mapSignUpInitiated(
      SignUpInitiated event, SignUpState state) async* {
    print(
        'email is $email, password is $password, gender is $gender, first name $firstName, last name $lastName, birthday $birthDate, interested in $interestedGender, school name $schoolName');
    if (email.isNotEmpty &&
            password.isNotEmpty &&
            gender.isNotEmpty &&
            firstName.isNotEmpty &&
            lastName.isNotEmpty &&
            birthDate.isNotEmpty &&
            interestedGender.isNotEmpty &&
            schoolName != null ||
        greekHouse != null) {
      try {
        yield state.rebuild((b) => b..signingUp = true);
        String token;
        final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
        // _firebaseMessaging.configure(
        //   onMessage: (Map<String, dynamic> message) async {
        //     print("onMessage: $message");
        //   },
        //   onLaunch: (Map<String, dynamic> message) async {
        //     print("onLaunch: $message");
        //   },
        //   onResume: (Map<String, dynamic> message) async {
        //     print("onResume: $message");
        //   },
        // );

        token = (await _firebaseMessaging.getToken())!;
        User user;
        final date = DateFormat('MM-dd-yyyy').parse(birthDate);
        print('date is $date');
        user = await Api.apiClient.newUser(
          firstName: firstName,
          lastName: lastName,
          email: email,
          greekHouse: greekHouse,
          university: schoolName,
          gender: gender,
          interestedIn: interestedGender,
          dateOfBirth: date.toString(),
          password: password,
          token: token,
        );
        if (user != null) {
          await SharedPref.pref.saveUser(user);
          yield state.rebuild((b) => b..signUpSuccessfully = true);
        } else {
          yield state.rebuild((b) => b
            ..signingUp = false
            ..signUpSuccessfully = false
            ..signUpError = ERROR_GETTING_DATA);
        }
      } catch (e) {
        print('AuthBloc => mapLoginInitiated => ERROR = $e');
        yield state.rebuild((b) => b
          ..signingUp = false
          ..signUpSuccessfully = false
          ..signUpError = ERROR_GETTING_DATA);
      }
    }
  }
}
