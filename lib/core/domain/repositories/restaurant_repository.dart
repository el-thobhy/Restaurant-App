import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/common/failure.dart';
import 'package:restaurant_app/core/domain/entities/detail.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';
import 'package:restaurant_app/core/domain/entities/search.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurant();
  Future<Either<Failure, List<Search>>> getSearch(String query);
  Future<Either<Failure, Detail>> getDetail(String id);
  Future<Either<Failure, String>> saveFavorite(Detail detail);
  Future<Either<Failure, String>> removeFavorite(Detail d);
  Future<bool> isAddedToFavorite(String id);
  Future<Either<Failure, List<Restaurant>>> getFavoriteRestaurant();
}
