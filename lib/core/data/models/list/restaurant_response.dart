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

  factory RestaurantResponse.fromNoJson() => const RestaurantResponse(
      error: true,
      message: 'No Internet Connection\nplease check your internet connection',
      count: 0,
      restaurant: []);

  @override
  List<Object> get props => [restaurant, message, error];
}
