import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/common/exception.dart';
import 'package:restaurant_app/core/common/failure.dart';
import 'package:restaurant_app/core/data/datasources/remote_data_source.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';
import 'package:restaurant_app/core/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;

  RestaurantRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurant() async {
    try {
      final result = await remoteDataSource.getRestaurant();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure("error ${e.message}"));
    } on SocketException {
      return const Left(
          ConnectionFailure("Please Connect To Internet Connection"));
    }
  }
}
