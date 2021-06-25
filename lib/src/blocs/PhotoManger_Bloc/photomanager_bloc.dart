import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crushly/Api/Api.dart';
import 'package:crushly/SharedPref/SharedPref.dart';
import 'package:crushly/models/User.dart';
import './bloc.dart';

class PhotomanagerBloc extends Bloc<PhotomanagerEvent, PhotomanagerState> {
  @override
  PhotomanagerState get initialState => InitialPhotomanagerState();

  @override
  Stream<PhotomanagerState> mapEventToState(
    PhotomanagerEvent event,
  ) async* {
    if (event is SetPhoto) {
      yield LoadingPhoto();
      String error;
      String photoUrl;
      String userId;
      await SharedPref.pref.getUser().then((user) {
        userId = user.id;
      });
      await Api.apiClient.setPhoto(event.image, userId).then((onValue) {
        print(onValue);
        photoUrl = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (photoUrl != null) {
        yield SetPhotoSuccess(photoUrl);
      } else {
        yield SetPhotoFailed(error);
      }
    }
  }
}
