import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/domain/entities/detail.dart';

class DetailResponse extends Equatable {
  final bool error;
  final String message;
  final Detail restaurant;

  const DetailResponse(
      {required this.error, required this.message, required this.restaurant});

  factory DetailResponse.fromJson(Map<String, dynamic> json) => DetailResponse(
      error: json['error'],
      message: json['message'],
      restaurant: Detail.fromJson(json['restaurant']));

  Map<String, dynamic> toJson() =>
      {'error': error, 'message': message, 'restaurant': restaurant};

  @override
  List<Object> get props => [error, message, restaurant];
}
