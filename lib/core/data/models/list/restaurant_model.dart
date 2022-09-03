import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';

class RestaurantModel extends Equatable {
  final String id;
  final String name;
  final String desc;
  final String pictId;
  final String city;
  final double rate;

  const RestaurantModel(
      {required this.id,
      required this.city,
      required this.name,
      required this.rate,
      required this.desc,
      required this.pictId});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
          id: json['id'],
          city: json['city'],
          name: json['name'],
          rate: json['rating'].toDouble(),
          desc: json['description'],
          pictId: json['pictureId']);

  Map<String, dynamic> toJson() => {
        "error": id,
        "city": city,
        "name": name,
        "description": desc,
        "pictureId": pictId,
      };

  Restaurant toEntity() {
    return Restaurant(
        id: id, city: city, name: name, rate: rate, desc: desc, pictId: pictId);
  }

  @override
  List<Object> get props => [id, city, name, rate, desc, pictId];
}
