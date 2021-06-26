
import 'package:meta/meta.dart';

@immutable
abstract class StoryState {}

class InitialStoryState extends StoryState {}

class AddingStorySuccess extends StoryState {}

class AddingStoryFailed extends StoryState {
  final String error;

  AddingStoryFailed(this.error);
}
class LoadingNewStory extends StoryState{}