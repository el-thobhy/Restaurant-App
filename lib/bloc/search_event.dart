part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchRestaurantName extends SearchEvent {
  final String query;

  const SearchRestaurantName({required this.query});

  @override
  List<Object> get props => [];
}
