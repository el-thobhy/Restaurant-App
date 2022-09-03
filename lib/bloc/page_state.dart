part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class InitialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashScreen extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashScreenLoad extends PageState {
  @override
  List<Object> get props => [];
}

class OnHomePage extends PageState {
  final int index;

  const OnHomePage({this.index = 0});

  @override
  List<Object> get props => [index];
}

class OnDetailPage extends PageState {
  final String idRestaurant;

  const OnDetailPage({required this.idRestaurant});

  @override
  List<Object> get props => [idRestaurant];
}

class OnSearchPage extends PageState {
  final String query;

  const OnSearchPage({required this.query});

  @override
  List<Object> get props => [query];
}
