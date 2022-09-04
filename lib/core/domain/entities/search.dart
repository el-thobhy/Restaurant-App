import 'package:equatable/equatable.dart';

class Search extends Equatable {
  final String id;
  final String name;
  final String desc;
  final String pictId;
  final String city;
  final double rate;

  const Search(
      {required this.id,
      required this.city,
      required this.name,
      required this.rate,
      required this.desc,
      required this.pictId});

  const Search.saveBookmark({
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