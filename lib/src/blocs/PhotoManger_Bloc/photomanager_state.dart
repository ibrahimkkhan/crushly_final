import 'package:meta/meta.dart';
import 'package:crushly/models/User.dart';

@immutable
abstract class PhotomanagerState {}
  
class InitialPhotomanagerState extends PhotomanagerState {}
class LoadingPhoto extends PhotomanagerState{}
class SetPhotoSuccess extends PhotomanagerState{
  final String photoUrl;
  SetPhotoSuccess(this.photoUrl);
}
class SetPhotoFailed extends PhotomanagerState{
  final String error;
  SetPhotoFailed(this.error);
}