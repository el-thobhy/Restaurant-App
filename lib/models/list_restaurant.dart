import 'package:equatable/equatable.dart';

class ListRestaurant extends Equatable {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurant;

  const ListRestaurant(
      {required this.error,
      required this.message,
      required this.count,
      required this.restaurant});

  factory ListRestaurant.fromJson(Map<String, dynamic> json) => ListRestaurant(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      restaurant: List<Restaurant>.from(
          json["restaurants"].map((a) => Restaurant.fromJson(a))));

  factory ListRestaurant.fromNoJson() => const ListRestaurant(
      error: true,
      message: 'No Internet Connection\nplease check your internet connection',
      count: 0,
      restaurant: []);

  @override
  List<Object> get props => [restaurant, message, error];
}

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String desc;
  final String pictId;
  final String city;
  final double rate;

  const Restaurant(
      {required this.id,
      required this.city,
      required this.name,
      required this.rate,
      required this.desc,
      required this.pictId});

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'],
      city: json['city'],
      name: json['name'],
      rate: json['rating'].toDouble(),
      desc: json['description'],
      pictId: json['pictureId']);

  @override
  List<Object> get props => [id, city, name, rate, desc, pictId];
}
