part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class InitialSearch extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final List<SearchResult> result;

  const SearchLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}
