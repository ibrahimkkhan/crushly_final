import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class LandingNavigationBloc extends Bloc<LandingNavigationEvent, LandingNavigationState> {
  @override
  LandingNavigationState get initialState => InitialLandingNavigationState();

  @override
  Stream<LandingNavigationState> mapEventToState(
    LandingNavigationEvent event,
  ) async* {
    if (event is NextPreview) {
      yield InitialLandingNavigationState();
      yield UpdatePreview();
    }
  }
}
