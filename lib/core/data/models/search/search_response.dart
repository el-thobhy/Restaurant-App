import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/data/models/search/search_model.dart';

class SearchResponse extends Equatable {
  final bool error;
  final String message;
  final int count;
  final List<SearchModel> result;

  const SearchResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.result,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        error: json['error'],
        message: '',
        result: List<SearchModel>.from(
            json['restaurants'].map((e) => SearchModel.fromJson(e))),
        count: json['founded'],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "result": List<dynamic>.from(result.map((e) => e.toJson())),
        "count": count,
      };
  @override
  List<Object> get props => [
        error,
        message,
        result,
      ];
}
