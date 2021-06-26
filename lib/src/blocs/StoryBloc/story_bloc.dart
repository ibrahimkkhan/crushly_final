import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crushly/Api/Api.dart';
import './bloc.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  @override
  StoryState get initialState => InitialStoryState();

  @override
  Stream<StoryState> mapEventToState(
    StoryEvent event,
  ) async* {
    if (event is NewStory) {
      yield LoadingNewStory();
      String error;
      bool result = false;

      await Api.apiClient
          .newStory(event.userId, event.text, event.forever, event.imagePath,
              event.imageData)
          .then((onValue) {
        result = onValue;
      }).catchError((onError) {
        error = onError.toString();
      });
      if (error == null && result) {
        yield AddingStorySuccess();
      } else {
        yield AddingStoryFailed(error);
      }
    }
  }
}
