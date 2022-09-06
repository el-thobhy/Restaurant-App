import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/common/exception.dart';
import 'package:restaurant_app/core/common/failure.dart';
import 'package:restaurant_app/core/data/datasources/local_data_source.dart';
import 'package:restaurant_app/core/data/datasources/remote_data_source.dart';
import 'package:restaurant_app/core/data/models/list/restaurant_table.dart';
import 'package:restaurant_app/core/domain/entities/detail.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';
import 'package:restaurant_app/core/domain/entities/search.dart';
import 'package:restaurant_app/core/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;
  final RestauranLocalDataSource localDataSource;

  RestaurantRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

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
      return const Left(ConnectionFailure("Network Error"));
    }
  }

  @override
  Future<Either<Failure, List<Search>>> getSearch(String query) async {
    try {
      final result = await remoteDataSource.getSearch(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure("error ${e.message}"));
    } on SocketException {
      return const Left(ConnectionFailure("Network Error"));
    }
  }

  @override
  Future<Either<Failure, Detail>> getDetail(String id) async {
    try {
      final result = await remoteDataSource.getDetail(id);
      return Right(result.restaurant.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Network Error'));
    }
  }

  @override
  Future<Either<Failure, String>> saveFavorite(Detail detail) async {
    try {
      final result = await localDataSource
          .insertFavorite(RestaurantTable.fromEntity(detail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeFavorite(Detail detail) async {
    try {
      final result = await localDataSource
          .removeFavorite(RestaurantTable.fromEntity(detail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToFavorite(String id) async {
    final result = await localDataSource.getRestaurantById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getFavoriteRestaurant() async {
    final result = await localDataSource.getRestaurantFavorite();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
