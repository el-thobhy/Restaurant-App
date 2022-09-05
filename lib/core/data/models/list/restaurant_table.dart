import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/domain/entities/detail.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';

class RestaurantTable extends Equatable {
  final String id;
  final String name;
  final String desc;
  final String pictId;
  final String city;
  final double rate;

  const RestaurantTable(
      {required this.id,
      required this.city,
      required this.name,
      required this.rate,
      required this.desc,
      required this.pictId});

  factory RestaurantTable.fromEntity(Detail restaurant) => RestaurantTable(
        id: restaurant.id,
        city: restaurant.city,
        name: restaurant.name,
        rate: restaurant.rate,
        desc: restaurant.desc,
        pictId: restaurant.pictId,
      );

  factory RestaurantTable.fromMap(Map<String, dynamic> map) => RestaurantTable(
      id: map['id'],
      city: map['city'],
      name: map['name'],
      rate: map['rate'],
      desc: map['description'],
      pictId: map['pictId']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'name': name,
        'rate': rate,
        'description': desc,
        'pictId': pictId,
      };

  Restaurant toEntity() => Restaurant.saveBookmark(
      id: id, city: city, name: name, rate: rate, desc: desc, pictId: pictId);

  @override
  List<Object?> get props => [id, city, name, rate, desc, pictId];
}
