import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantEmpty extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantLoading extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurantList;

  const RestaurantLoaded(this.restaurantList);

  @override
  List<Object> get props => [restaurantList];
}

class RestaurantError extends RestaurantState {
  final String message;

  const RestaurantError(this.message);

  @override
  List<Object> get props => [message];
}
