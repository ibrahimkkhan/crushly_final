
abstract class AuthEvent {}

class GetLocation extends AuthEvent {}

class ResetSignInError extends AuthEvent {}

class ResetSignUpError extends AuthEvent {}

class EmailChanged extends AuthEvent {
  final String email;
  final bool passwordValidation;

  EmailChanged(this.email, this.passwordValidation);
}

class UploadImages extends AuthEvent {}

class CheckEmail extends AuthEvent {
  final String email;

  CheckEmail(this.email);
}

class PasswordChanged extends AuthEvent {
  final String password;
  final bool emailValidation;

  PasswordChanged(this.password, this.emailValidation);
}

class LoginInitiated extends AuthEvent {
  final String? email;
  final String? password;

  LoginInitiated({
    this.email,
    this.password,
  });
}

class SignUpInitiated extends AuthEvent {
  final String? email;
  final String? gender;
  final String? lastName;
  final String? password;
  final String? firstName;
  final String? birthDate;
  final String? schoolType;
  final String? schoolName;
  final String? primaryPhoto;
  final String? interestedGender;
  final List<String>? photos;

  SignUpInitiated({
    this.email,
    this.gender,
    this.lastName,
    this.password,
    this.firstName,
    this.birthDate,
    this.schoolType,
    this.schoolName,
    this.primaryPhoto,
    this.interestedGender,
    this.photos,
  });
}

class GetSignInInitialState extends AuthEvent {}

class ResetEmailAvailable extends AuthEvent {}

class GetSignUpInitialState extends AuthEvent {}

class GetLocationInitialState extends AuthEvent {}
