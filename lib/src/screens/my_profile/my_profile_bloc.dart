import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crushly/Api/Api.dart';
import 'package:crushly/Screens/my_profile/my_profile_event.dart';
import 'package:crushly/Screens/my_profile/my_profile_state.dart';
import 'package:crushly/SharedPref/SharedPref.dart';
import 'package:crushly/models/User.dart';
import 'package:crushly/models/upload_photo.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  @override
  MyProfileState get initialState => MyProfileState.initial();

  @override
  Stream<MyProfileState> mapEventToState(MyProfileEvent event) async* {
    print('MyProfileBloc => mapEventToState => event = ${event.toString()}');
    if (event is GetMyProfile) {
      yield* mapGetMyProfile(event);
    } else if (event is EditProfile) {
      if (!state.isLoading) yield MyProfileState.editingProfile(state);
    } else if (event is ChangeProfilePhoto) {
      try {
        yield state.rebuild((b) => b..isLoading = true);
        final response = await Api.apiClient.setPhotos(
          [
            UploadPhoto(event.image, 0),
          ],
        );
        this.add(GetMyProfile());
        if (response.isNotEmpty)
          yield state.rebuild((b) => b..isLoading = false);
        else
          yield state.rebuild((b) => b..isLoading = false);
      } catch (e) {
        print('e is $e');
        yield state.rebuild((b) => b..isLoading = false);
      }
    } else if (event is ChangeImages) {
      try {
        yield state.rebuild((b) => b..isLoading = true);
        List<UploadPhoto> photos = [];
        for (int i = 0; i < event.images.length; i++) {
          photos.add(
              UploadPhoto(event.images[i], state.user.photos.length + i + 1));
        }
        await Api.apiClient.setPhotos(photos);
        this.add(GetMyProfile());
      } catch (e) {
        yield state.rebuild((b) => b..isLoading = false);
      }
    }
  }

  Stream<MyProfileState> mapGetMyProfile(MyProfileEvent event) async* {
    print('MyProfileBloc => mapEventToState => Loading..');
    yield MyProfileState.loadingMyProfile(state);
    final myId = await SharedPref.pref.getMyId();
    User user;
    await Api.apiClient.getMyInfo().then((User userResponse) {
      print('MyProfileBloc => mapEventToState => Success.');
      user = userResponse;
    }).catchError((error) {
      print('MyProfileBloc => mapEventToState => ERROR = $error');
    });
    if (user != null) {
      print("here user = " + user.followCount.toString());
      yield MyProfileState.profileLoaded(state, user);
    } else
      yield MyProfileState.errorLoadingProfile(state);

//    yield MyProfileState.profileLoaded(state, DumData.user); // TODO: remove this
  }
}
