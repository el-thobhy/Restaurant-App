part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashScreen extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSplashLoad extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToHomePage extends PageEvent {
  final int index;

  const GoToHomePage({this.index = 0});

  @override
  List<Object> get props => [index];
}

class GoToDetailPage extends PageEvent {
  final String idRestaurant;

  const GoToDetailPage({required this.idRestaurant});

  @override
  List<Object> get props => [idRestaurant];
}

class GoToSearchPage extends PageEvent {
  final String query;

  const GoToSearchPage({required this.query});

  @override
  List<Object> get props => [query];
}
