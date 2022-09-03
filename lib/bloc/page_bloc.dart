import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';

part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(InitialPage()) {
    on<GoToSplashScreen>((event, emit) async {
      emit(OnSplashScreen());
      await Future.delayed(const Duration(seconds: 4));
      emit(const OnHomePage(index: 0));
    });
    on<GoToHomePage>((event, emit) => emit(const OnHomePage()));
    on<GoToDetailPage>(
        (event, emit) => emit(OnDetailPage(idRestaurant: event.idRestaurant)));
    on<GoToSearchPage>((event, emit) => emit(OnSearchPage(query: event.query)));
  }
}
