library auth_state;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:crushly/utils/constants.dart';

import 'auth_bloc.dart';

part 'auth_state.g.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

abstract class SignInState extends AuthState
    implements Built<SignInState, SignInStateBuilder> {
  bool get signingIn;

  bool get signInValidation;

  bool get emailValidation;

  bool get passwordValidation;

  bool get signInSuccessfully;

  int get signInError;

  SignInState._();

  factory SignInState([updates(SignInStateBuilder b)]) = _$SignInState;

  factory SignInState.initial() {
    return SignInState((b) => b
      ..signingIn = false
      ..signInValidation = false
      ..emailValidation = true
      ..passwordValidation = true
      ..signInSuccessfully = false
      ..signInError = NO_ERROR);
  }
}

abstract class SignUpState extends AuthState
    implements Built<SignUpState, SignUpStateBuilder> {
  bool get signingUp;

  bool get signUpValidation;

  bool get emailValidation;

  bool get passwordValidation;

  bool get signUpSuccessfully;

  bool get uploadPhotoSuccessfully;

  @nullable
  bool get isEmailAvailable;

  int get signUpError;

  SignUpState._();

  factory SignUpState([updates(SignUpStateBuilder b)]) = _$SignUpState;

  static final _bloc = new AuthBloc();

  // final isEmailPresent = _bloc.email != null ? true : false;
  // final isPasswordPresent = _bloc.password != null ? true : false;

  bool get isEmailPresent {
    return _bloc.email != null ? true : false;
  }

  bool get isPasswordPresent {
    return _bloc.password != null ? true : false;
  }

  factory SignUpState.initial() {
    return SignUpState((b) => b
      ..signingUp = false
      ..signUpValidation = false
      ..emailValidation = false
      ..passwordValidation = false
      ..signUpSuccessfully = false
      ..uploadPhotoSuccessfully = false
      ..signUpError = NO_ERROR);
  }
}

abstract class LocationState extends AuthState
    implements Built<LocationState, LocationStateBuilder> {
  bool get acquiringLocation;

  bool get errorGettingLocation;

  bool get locationAcquiredSuccessfully;

  LocationState._();

  factory LocationState([updates(LocationStateBuilder b)]) = _$LocationState;

  factory LocationState.initial() {
    return LocationState((b) => b
      ..acquiringLocation = false
      ..errorGettingLocation = false
      ..locationAcquiredSuccessfully = false);
  }
}
