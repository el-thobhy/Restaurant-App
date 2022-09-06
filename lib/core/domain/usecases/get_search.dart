import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/domain/entities/search.dart';
import 'package:restaurant_app/core/domain/repositories/restaurant_repository.dart';

import '../../common/failure.dart';

class GetSearch {
  final RestaurantRepository repository;

  GetSearch(this.repository);

  Future<Either<Failure, List<Search>>> execute(String query) {
    return repository.getSearch(query);
  }
}
