import 'package:restaurant_app/core/domain/entities/search.dart';

class SearchModel {
  final String id;
  final String name;
  final String desc;
  final String pictId;
  final String city;
  final double rate;

  SearchModel({
    required this.id,
    required this.city,
    required this.rate,
    required this.pictId,
    required this.desc,
    required this.name,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        id: json['id'],
        city: json['city'],
        rate: json['rating'].toDouble(),
        pictId: json['pictureId'],
        desc: json['description'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "error": id,
        "city": city,
        "name": name,
        "description": desc,
        "pictureId": pictId,
      };

  Search toEntity() {
    return Search(
      id: id,
      city: city,
      name: name,
      rate: rate,
      desc: desc,
      pictId: pictId,
    );
  }

  List<Object> get props => [
        id,
        city,
        name,
        rate,
        desc,
        pictId,
      ];
}
