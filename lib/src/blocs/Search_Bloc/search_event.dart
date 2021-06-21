import 'package:meta/meta.dart';

@immutable
abstract class SearchEvent {}

class Search extends SearchEvent {
  final String query;
  Search(this.query);
}

class MoreSearch extends SearchEvent {
  final String query;
  MoreSearch(this.query);
}
