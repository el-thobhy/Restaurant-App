import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/list_restaurant.dart';
import 'package:restaurant_app/services/api_services.dart';

part 'restaurant_event.dart';

part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(InitialRestaurant()) {
    on<GetRestaurant>((event, emit) async {
      emit(RestaurantLoading());
      var resto = await ApiServices().getListRestaurant();
      if (resto.error != true) {
        emit(RestaurantLoaded(restaurantList: resto.restaurant));
      } else {
        emit(RestaurantError(message: resto.message));
      }
    });
  }
}
