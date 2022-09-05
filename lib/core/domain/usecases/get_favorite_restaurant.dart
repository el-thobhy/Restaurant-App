import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/common/failure.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';
import 'package:restaurant_app/core/domain/repositories/restaurant_repository.dart';

class GetFavoriteRestaurant {
  final RestaurantRepository _repository;

  GetFavoriteRestaurant(this._repository);

  Future<Either<Failure, List<Restaurant>>> execute() {
    return _repository.getFavoriteRestaurant();
  }
}