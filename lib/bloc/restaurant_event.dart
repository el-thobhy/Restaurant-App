part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();
}

class GetRestaurant extends RestaurantEvent {
  @override
  List<Object> get props => [];
}
