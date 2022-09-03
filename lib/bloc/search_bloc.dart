import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/models/search_restaurant.dart';
import 'package:restaurant_app/services/api_services.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialSearch()) {
    on<SearchRestaurantName>((event, emit) async {
      emit(SearchLoading());
      var resto = await ApiServices().searchRestaurant(event.query);
      if (resto.error != true) {
        emit(SearchLoaded(result: resto.result));
      } else {
        emit(SearchError(message: resto.message));
      }
    });
  }
}
