import 'package:meta/meta.dart';

@immutable
abstract class LandingNavigationState {}

class InitialLandingNavigationState extends LandingNavigationState {}
class UpdatePreview extends LandingNavigationState {}