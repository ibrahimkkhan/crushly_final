import 'dart:convert';

import 'package:crushly/BLocs/Massenger_Bloc/massenger_bloc.dart';
import 'package:crushly/BLocs/Massenger_Bloc/massenger_event.dart';
import 'package:crushly/BLocs/Massenger_Bloc/massenger_state.dart';
import 'package:crushly/BLocs/auth_bloc/auth_bloc.dart';
import 'package:crushly/BLocs/auth_bloc/auth_event.dart';
import 'package:crushly/BLocs/auth_bloc/auth_state.dart';
import 'package:crushly/MainScreen.dart';
import 'package:crushly/Screens/auth/sign_in.dart';
import 'birthday_view.dart';
import 'email_and_password_view.dart';
import 'full_name_view.dart';
import 'gender_screen.dart';
import 'gender_view.dart';
import 'school_choice_view.dart';
import 'sign_up_enter_university.dart';
import 'upload_photos_view.dart';
import 'package:crushly/SharedPref/SharedPref.dart';
import '../../theme/theme.dart';
import 'package:crushly/utils/CustomDotsIndicator.dart';
import 'package:crushly/utils/constants.dart';
import 'package:crushly/utils/our_toast.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:convert';

import 'greek_house.dart'; // for the utf8.encode method

double value = 1 / 7;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final _bloc = new AuthBloc();
  FocusNode focus1;
  FocusNode focus2;
  PageController _pageController = PageController(initialPage: PAGE_NAME);
  double currentIndicatorPage = 0.0;
  int currentPage = PAGE_NAME;
  Size screenSize;
  bool birthdayError = false;
  bool febError = false;
  bool showIcon = false;
  bool emailValidationError = false;

  @override
  void initState() {
    focus1 = FocusNode();
    focus2 = FocusNode();
    _pageController.addListener(
      () => WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
            currentPage = _pageController.page.toInt();
            FocusScope.of(context).unfocus();
          })),
    );
    _bloc.add(GetSignUpInitialState());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (_pageController.page.floor() == PAGE_NAME) {
          return true;
        } else {
          if (_pageController.page.floor() == PAGE_GENDER)
            _bloc.add(ResetEmailAvailable());
          _pageController.previousPage(
              duration: Duration(milliseconds: 350), curve: Curves.ease);
          return false;
        }
      },
      child: Scaffold(
        //no need scrollview anymore this will fix it.
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        backgroundColor: pageBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: pink,
            ),
            onPressed: () {
              if (_pageController.page.floor() == PAGE_NAME) {
                Navigator.of(context).pop();
                return true;
              } else {
                print('page number is ${_pageController.page}');
                if (_pageController.page.floor() == PAGE_GENDER)
                  _bloc.add(ResetEmailAvailable());
                _pageController.previousPage(
                    duration: Duration(milliseconds: 350), curve: Curves.ease);
                return false;
              }
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(pink),
                value: value,
              ),
            ),
            Flexible(
              flex: 4,
              child: BlocListener(
                bloc: BlocProvider.of<MassengerBloc>(context),
                condition: (_, cur) => cur is Connected,
                listener: (context, MassengerState state) {
                  print('state in listener $state');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => MainScreen()),
                    (_) => false,
                  );
                  print('uploaded and connected');
                },
                child: BlocListener(
                  bloc: _bloc,
                  listener: (context, AuthState state) {
                    if (state is SignUpState) {
                      print('statee is ${state}');
                      if (state.isEmailAvailable != null &&
                          state.isEmailAvailable &&
                          _pageController.page.floor() != PAGE_PHOTOS) {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 350),
                            curve: Curves.ease);
                        _bloc.add(ResetEmailAvailable());
                      }
//                    else if (state.isEmailAvailable != null && !state.isEmailAvailable) {
//                      Fluttertoast.showToast(
//                          msg: "The email you entered already exists, try another one",
//                          toastLength: Toast.LENGTH_SHORT,
//                          gravity: ToastGravity.CENTER,
//                          timeInSecForIos: 1,
//                          backgroundColor: toastColor,
//                          textColor: Colors.white,
//                          fontSize: 16.0
//                      );
//                    }
                      if (state.signUpSuccessfully &&
                          _pageController.page.floor() != PAGE_PHOTOS) {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 350),
                            curve: Curves.ease);
                      }
                      if (state.uploadPhotoSuccessfully) {
                        BlocProvider.of<MassengerBloc>(context).add(Connect());
                        /*showToastWidget(toast(
                            screenSize,
                            'lib/Fonts/add_photo.svg',
                            "Upload successful!",
                            false,
                            () {}));

                        showToastWidget(toast(
                            screenSize,
                            'lib/Fonts/photo_error.svg',
                            "Upload error!",
                            true,
                                () {}));*/
                      }
                    }
                  },
                  child: BlocBuilder(
                    bloc: _bloc,
                    builder: (context, AuthState state) {
                      if (state is SignUpState) {
                        if (state.signUpError != NO_ERROR) {
                          // TODO: handle error and show error message
                          _bloc.add(ResetSignUpError());
                        }
                        return Stack(
                          children: <Widget>[
                            PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _pageController,
                              onPageChanged: (int index) async {
                                if (index == PAGE_PHOTOS) {
                                  await [Permission.storage, Permission.photos]
                                      .request();
                                }
                              },
                              children: <Widget>[
                                FullNameView(
                                    focusNode: focus1,
                                    focusNode2: focus2,
                                    firstName: _bloc.firstName,
                                    lastName: _bloc.lastName,
                                    firstNameChanged: (firstName) =>
                                        setState(() {
                                          _bloc.firstName = firstName;
                                        }),
                                    lastNameChanged: (lastName) => setState(() {
                                          _bloc.lastName = lastName;
                                        }),
                                    onSubmitted: () {
                                      if (_bloc.firstName != null &&
                                          _bloc.firstName.isNotEmpty &&
                                          _bloc.lastName != null &&
                                          _bloc.lastName.isNotEmpty) {
                                        _pageController.nextPage(
                                          duration: Duration(milliseconds: 350),
                                          curve: Curves.ease,
                                        );
                                      }
                                    }),
                                EmailAndPasswordView(
                                  focus1: focus1,
                                  focus2: focus2,
                                  email: _bloc.email,
                                  password: _bloc.password,
                                  emailValidationError: state.emailValidation,
                                  isEmailAvailable: state.isEmailAvailable,
                                  onSubmitted: () {
                                    if (state.passwordValidation &&
                                        state.emailValidation)
                                      _bloc.add(CheckEmail(_bloc.email));
                                  },
                                  passwordValidationError:
                                      state.passwordValidation,
                                  emailChanged: (email) => _bloc.add(
                                      EmailChanged(
                                          email, state.passwordValidation)),
                                  passwordChanged: (password) => _bloc.add(
                                      PasswordChanged(
                                          password, state.emailValidation)),
                                ),
                                GenderView(
                                  gender: _bloc.gender,
                                  newValue: 3 / 7,
                                  firstText:
                                      'Nice to meet you\n${_bloc.firstName ?? ''}!',
                                  secondText: 'I\'m a...',
                                  genderChanged: (gender) {
                                    setState(() {
                                      switch (gender) {
                                        case 'Man':
                                          _bloc.gender = 'male';
                                          break;
                                        case 'Woman':
                                          _bloc.gender = 'female';
                                          break;
                                        case 'Other':
                                          _bloc.gender = 'other';
                                          break;
                                        default:
                                          _bloc.gender = gender;
                                      }
                                    });
                                  },
                                  genderType: GenderType.GENDER,
                                ),
                                GenderView(
                                  gender: _bloc.interestedGender,
                                  newValue: 4 / 7,
                                  secondText: 'I\'m interested in...',
                                  genderChanged: (interestedGender) {
                                    setState(() {
                                      switch (interestedGender) {
                                        case 'Man':
                                          _bloc.interestedGender = 'male';
                                          break;
                                        case 'Woman':
                                          _bloc.interestedGender = 'female';
                                          break;
                                        case 'Other':
                                          _bloc.gender = 'other';
                                          break;
                                        default:
                                          _bloc.interestedGender =
                                              interestedGender;
                                      }
                                    });
                                  },
                                  genderType: GenderType.INTERESTED_IN,
                                ),
                                BirthdayView(
                                  birthDate: _bloc.birthDate,
                                  birthdayChanged:
                                      (birthDate, bdError, fbError) {
                                    _bloc.birthDate = birthDate;
                                    birthdayError = bdError;
                                    febError = fbError;
                                    if (birthDate[9] != 'Y')
                                      FocusScope.of(context).unfocus();
                                  },
                                ),
                                EnterUniversity(
                                  schoolName: _bloc.schoolName.name,
                                  onSchoolChanged: (String university) {
                                    setState(() {
                                      _bloc.schoolName.name = university;
                                    });
                                  },
                                ),
                                GreekHouse(
                                  houseName: _bloc.greekHouse,
                                  houseNameChanged: (greekHouse) {
                                    setState(() {
                                      _bloc.greekHouse = greekHouse;
                                    });
                                  },
                                ),
                                // SchoolChoiceView(
                                //   schoolName: _bloc.schoolName != null
                                //       ? _bloc.schoolName.name
                                //       : '',
                                //   greekHouse: _bloc.greekHouse,
                                //   schoolNameChanged: (University university) {
                                //     setState(() {
                                //       _bloc.schoolName = university;
                                //     });
                                //   },
                                //   greekHouseChanged: (String greekHouse) =>
                                //       setState(() {
                                //     _bloc.greekHouse = greekHouse;
                                //   }),
                                // ),
                                UploadPhotosView(
                                  photoList: _bloc.photos,
                                  primaryIndex: _bloc.primaryPhotoIndex,
                                  onPhotosChanged: (photoList) {
                                    _bloc.photos = photoList;
                                    setState(() {});
                                  },
                                  onPrimaryIndexChanged: (primaryIndex) =>
                                      _bloc.primaryPhotoIndex = primaryIndex,
                                ),
                              ],
                            ),
                            state.signingUp
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(),
                          ],
                        );
                      } else
                        return Container();
                    },
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 8.0,
                    right: screenSize.width / 12.5,
                    left: screenSize.width / 12.5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: BlocBuilder(
                    bloc: _bloc,
                    builder: (context, AuthState state) {
                      if (state is SignUpState) {
                        showIcon = currentPageValidation(state);
                        return GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (currentPageValidation(state)) {
                              /*if (currentPage == PAGE_NAME) {
                                if (_bloc.firstName != null &&
                                    _bloc.firstName.isNotEmpty &&
                                    _bloc.lastName != null &&
                                    _bloc.lastName.isNotEmpty) {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 350),
                                    curve: Curves.ease,
                                  );
                                }
                              }*/
                              if (currentPage == PAGE_UNIVERSITY) {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 350),
                                  curve: Curves.ease,
                                );
                              } else if (currentPage == PAGE_GEEK_HOUSE) {
                                _bloc.add(SignUpInitiated());
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 350),
                                  curve: Curves.ease,
                                );
                              } else if (currentPage == PAGE_PHOTOS) {
                                if (_bloc.photos.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          'You have to add atleast one image before proceeding to the next step');
                                } else {
                                  _bloc.add(UploadImages());
                                  if (state.uploadPhotoSuccessfully) {
                                    print("upload success");
                                  } else {
                                    print("upload fail");
                                  }
                                }
                              } else if (currentPage == PAGE_EMAIL_AND_PASSWORD)
                                _bloc.add(CheckEmail(_bloc.email));
                              else if (_pageController.page.floor() !=
                                  PAGE_PHOTOS)
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 350),
                                  curve: Curves.ease,
                                );
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: showIcon ? pink : grey,
                            size: screenSize.height * 0.04,
                          ),
                        );
                      } else
                        return Container();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool currentPageValidation(SignUpState state) {
    print(_bloc.greekHouse);
    switch (currentPage) {
      case PAGE_NAME:
        RegExp regExp = new RegExp(
          "[a-zA-Z]+",
          caseSensitive: false,
          multiLine: false,
        );
        return _bloc.firstName.isNotEmpty &&
            _bloc.lastName.isNotEmpty &&
            (regExp.stringMatch(_bloc.firstName) != null &&
                regExp.stringMatch(_bloc.firstName).length ==
                    _bloc.firstName.length) &&
            (regExp.stringMatch(_bloc.lastName) != null &&
                regExp.stringMatch(_bloc.lastName).length ==
                    _bloc.lastName.length);
      case PAGE_EMAIL_AND_PASSWORD:
        return state.signUpValidation;
      case PAGE_GENDER:
        return _bloc.gender.isNotEmpty;
      case PAGE_INTERESTED_IN_GENDER:
        return _bloc.interestedGender.isNotEmpty;
      case PAGE_BIRTH_DATE:
        return _bloc.birthDate.length >= 8 && !birthdayError && !febError;
      case PAGE_UNIVERSITY:
        return _bloc.schoolName != null &&
            _bloc.schoolName.name != null &&
            _bloc.schoolName.name.isNotEmpty;
      case PAGE_GEEK_HOUSE:
        return _bloc.greekHouse.isNotEmpty;
      case PAGE_PHOTOS:
        return _bloc.photos.isNotEmpty && _bloc.photos.length > 3;
      default:
        return true;
    }
  }
}

const PAGE_NAME = 0;
const PAGE_EMAIL_AND_PASSWORD = 1;
const PAGE_GENDER = 2;
const PAGE_INTERESTED_IN_GENDER = 3;
const PAGE_BIRTH_DATE = 4;
const PAGE_UNIVERSITY = 5;
const PAGE_GEEK_HOUSE = 6;
const PAGE_PHOTOS = 7;

/*Expanded(
                      child: DotsIndicator(
                        dotsCount: 7,
                        position: _pageController.hasClients
                            ? _pageController.page
                            : 0,
                        decorator: DotsDecorator(
                          color: dividerColor,
                          activeColor: pink,
                          spacing: EdgeInsets.all(4.0),
                          size: Size.square(screenSize.width / 46.87),
                          activeSize: Size(screenSize.width / 15.625,
                              screenSize.width / 46.87),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                    ),*/
//                    Expanded(
//                      child: PageIndicator(
//                        length: 7,
//                        color: lightGrey,
//                        selectedColor: accent,
//                        indicatorSpace: 4.0,
//                        indicatorShape: IndicatorShape.roundRectangleShape(
//                            size: Size(30, 12), cornerSize: Size.square(15)),
//                        currentPage: _pageController.hasClients
//                            ? _pageController.page
//                            : 0,
//                        initialPage: _pageController.hasClients
//                            ? _pageController.page
//                            : 0,
//                      ),
//                    ),

/*Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: MaterialButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (currentPageValidation(state)) {
                                  if (currentPage == PAGE_UNIVERSITY)
                                    _bloc.add(SignUpInitiated());
                                  else if (currentPage == PAGE_PHOTOS) {
                                    if (_bloc.photos.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg:
                                              'You have to add atleast one image before proceeding to the next step');
                                    } else {
                                      _bloc.add(UploadImages());
                                    }
                                  } else if (currentPage ==
                                      PAGE_EMAIL_AND_PASSWORD)
                                    _bloc.add(CheckEmail(_bloc.email));
                                  else
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.ease,
                                    );
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)),
                              ),
                              child: Container(
                                width: 60.0,
                                height: 90.0,
                                decoration: BoxDecoration(
                                    gradient: currentPageValidation(state)
                                        ? appGradient
                                        : greyGradient,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );



                          */
