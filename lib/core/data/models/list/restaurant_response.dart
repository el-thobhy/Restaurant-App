import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/data/models/list/restaurant_model.dart';

class RestaurantResponse extends Equatable {
  final bool error;
  final String message;
  final int count;
  final List<RestaurantModel> restaurant;

  const RestaurantResponse(
      {required this.error,
      required this.message,
      required this.count,
      required this.restaurant});

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
          error: json["error"],
          message: json["message"],
          count: json["count"],
          restaurant: List<RestaurantModel>.from(
              json["restaurants"].map((a) => RestaurantModel.fromJson(a))));

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurant": List<dynamic>.from(restaurant.map((e) => e.toJson())),
  };

  @override
  List<Object> get props => [restaurant, message, error];
}
