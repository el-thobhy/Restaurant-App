part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
}

class InitialRestaurant extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantLoading extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurantList;

  const RestaurantLoaded({required this.restaurantList});

  @override
  List<Object> get props => [restaurantList];
}

class RestaurantError extends RestaurantState {
  final String message;

  const RestaurantError({required this.message});

  @override
  List<Object> get props => [message];
}
