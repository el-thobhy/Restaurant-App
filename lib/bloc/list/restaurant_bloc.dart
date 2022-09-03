import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/bloc/list/restaurant_state.dart';
import 'package:restaurant_app/core/domain/usecases/get_restaurant.dart';
import 'package:rxdart/rxdart.dart';

part 'restaurant_event.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final GetRestaurant _restaurant;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  RestaurantBloc(this._restaurant) : super(RestaurantEmpty()) {
    on<RestaurantEvent>((event, emit) async {
      emit(RestaurantLoading());
      final result = await _restaurant.execute();

      result.fold(
        (failure) {
          emit(RestaurantError(failure.message));
        },
        (data) {
          emit(RestaurantLoaded(data));
        },
      );
    }, transformer: debounce(const Duration(microseconds: 500)));
  }
}
