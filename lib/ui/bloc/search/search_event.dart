part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class OnQueryChange extends SearchEvent {
  final String query;

  const OnQueryChange({required this.query});

  @override
  List<Object> get props => [];
}
