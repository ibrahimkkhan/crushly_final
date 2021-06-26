import 'package:meta/meta.dart';

@immutable
abstract class InlistsearchEvent {}

class Search extends InlistsearchEvent {
  final String query;
  final int listNum;

  Search(this.query, this.listNum);
}

class MoreSearch extends InlistsearchEvent {
  final String query;
  final int listNum;
  MoreSearch(this.query, this.listNum);
}
