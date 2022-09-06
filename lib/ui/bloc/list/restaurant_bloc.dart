import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/domain/usecases/get_restaurant.dart';
import 'package:restaurant_app/ui/bloc/list/restaurant_state.dart';
import 'package:rxdart/rxdart.dart';

part 'restaurant_event.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final GetRestaurant _restaurant;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  RestaurantBloc(this._restaurant) : super(RestaurantEmpty()) {
    on<OnFetchGetRestaurant>((event, emit) async {
      emit(RestaurantLoading());
      final result = await _restaurant.execute();

      result.fold(
        (failure) {
          emit(RestaurantError(failure.message));
        },
        (data) {
          data.isNotEmpty
              ? emit(RestaurantLoaded(data))
              : emit(RestaurantEmpty());
        },
      );
    }, transformer: debounce(const Duration(microseconds: 500)));
  }
}
