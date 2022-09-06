import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/domain/entities/search.dart';

class SearchTable extends Equatable {
  final String id;
  final String name;
  final String desc;
  final String pictId;
  final String city;
  final double rate;

  const SearchTable({
    required this.id,
    required this.city,
    required this.name,
    required this.rate,
    required this.desc,
    required this.pictId,
  });

  factory SearchTable.fromEntity(SearchTable restaurant) => SearchTable(
        id: restaurant.id,
        city: restaurant.city,
        name: restaurant.name,
        rate: restaurant.rate,
        desc: restaurant.desc,
        pictId: restaurant.pictId,
      );

  factory SearchTable.fromMap(Map<String, dynamic> map) => SearchTable(
        id: map['id'],
        city: map['city'],
        name: map['name'],
        rate: map['rate'],
        desc: map['description'],
        pictId: map['pictId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'name': name,
        'rate': rate,
        'description': desc,
        'pictId': pictId,
      };

  Search toEntity() => Search.saveBookmark(
        id: id,
        city: city,
        name: name,
        rate: rate,
        desc: desc,
        pictId: pictId,
      );

  @override
  List<Object?> get props => [
        id,
        city,
        name,
        rate,
        desc,
        pictId,
      ];
}
