import 'package:crushly/models/search_user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:crushly/models/User.dart';

@immutable
abstract class SearchState extends Equatable {}

class InitialSearchState extends SearchState {
  @override
  List<Object> get props => null;
}

class LoadingSearch extends SearchState {
  @override
  List<Object> get props => null;
}

class SearchResult extends SearchState {
  final String query;
  final List<SearchUser> result;
  final bool hasReachedMax;
  SearchResult({this.result, this.hasReachedMax,this.query})
      : super();
  SearchResult copyWith({
    List<SearchUser> result,
    bool hasReachedMax,
    String query
  }) {
    return SearchResult(
      result: result ?? this.result,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      query: query
    );
  }

  @override
  List<Object> get props => this.result;

}

class SearchError extends SearchState {
  final String error;
  SearchError(this.error);

  @override
  // TODO: implement props
  List<Object> get props => null;
}
