import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/common/failure.dart';
import 'package:restaurant_app/core/domain/entities/detail.dart';
import 'package:restaurant_app/core/domain/repositories/restaurant_repository.dart';

class SaveFavorite {
  final RestaurantRepository repository;

  SaveFavorite(this.repository);

  Future<Either<Failure, String>> execute(Detail detail) {
    return repository.saveFavorite(detail);
  }
}
