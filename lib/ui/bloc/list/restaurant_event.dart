part of 'restaurant_bloc.dart';

class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class OnFetchGetRestaurant extends RestaurantEvent {
  final int id;

  const OnFetchGetRestaurant(this.id);

  @override
  List<Object> get props => [id];
}
