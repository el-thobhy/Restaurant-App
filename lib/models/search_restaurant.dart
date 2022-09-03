import 'package:equatable/equatable.dart';

class SearchRestaurant extends Equatable {
  final bool error;
  final String message;
  final int count;
  final List<SearchResult> result;

  const SearchRestaurant(
      {required this.error,
      required this.message,
      required this.count,
      required this.result});

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) =>
      SearchRestaurant(
          error: json['error'],
          message: '',
          result: List<SearchResult>.from(
              json['restaurants'].map((e) => SearchResult.fromJson(e))),
          count: json['founded']);

  factory SearchRestaurant.fromJsonNo() => const SearchRestaurant(
        error: true,
        message:
            "No Internet Connection\nPlease check your internet connection",
        result: [],
        count: 0,
      );

  @override
  List<Object> get props => [error, message, result];
}

class SearchResult {
  final String id;
  final String name;
  final String desc;
  final String pictId;
  final String city;
  final double rate;

  SearchResult(
      {required this.id,
      required this.city,
      required this.rate,
      required this.pictId,
      required this.desc,
      required this.name});

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
      id: json['id'],
      city: json['city'],
      rate: json['rating'].toDouble(),
      pictId: json['pictureId'],
      desc: json['description'],
      name: json['name']);
}
