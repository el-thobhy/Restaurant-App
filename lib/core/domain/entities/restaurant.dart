import 'package:equatable/equatable.dart';

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

  const Restaurant.saveBookmark({
    required this.id,
    required this.city,
    required this.name,
    required this.rate,
    required this.desc,
    required this.pictId,
  });

  @override
  List<Object?> get props => [id, city, name, rate, desc, pictId];
}
