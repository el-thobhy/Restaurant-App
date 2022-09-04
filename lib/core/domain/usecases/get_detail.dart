import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/common/failure.dart';
import 'package:restaurant_app/core/domain/entities/detail.dart';
import 'package:restaurant_app/core/domain/repositories/restaurant_repository.dart';

class GetDetail {
  final RestaurantRepository repository;

  GetDetail(this.repository);

  Future<Either<Failure, Detail>> execute(String id) {
    return repository.getDetail(id);
  }
}