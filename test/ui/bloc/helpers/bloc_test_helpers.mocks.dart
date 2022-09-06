import 'package:restaurant_app/core/domain/entities/detail.dart';
import 'package:restaurant_app/core/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_app/core/domain/usecases/get_detail.dart';
import 'package:restaurant_app/core/domain/usecases/get_restaurant.dart';
import 'package:restaurant_app/core/common/failure.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'dart:async' as asyncc;

class FakeRepository extends Fake implements RestaurantRepository {}

class FakeEither<L, R> extends Fake implements Either<L, R> {}

class MockGetRestaurant extends Mock implements GetRestaurant {
  MockGetRestaurant() {
    throwOnMissingStub(this);
  }

  @override
  RestaurantRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: FakeRepository()) as RestaurantRepository);
  @override
  Future<Either<Failure, List<Restaurant>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<Either<Failure, List<Restaurant>>>.value(
                  FakeEither<Failure, List<Restaurant>>()))
          as asyncc.Future<Either<Failure, List<Restaurant>>>);
}

class MockGetDetail extends Mock implements GetDetail {
  MockGetDetail() {
    throwOnMissingStub(this);
  }

  @override
  RestaurantRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: FakeRepository()) as RestaurantRepository);
  @override
  Future<Either<Failure, Detail>> execute(String? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<Either<Failure, Detail>>.value(
                  FakeEither<Failure, Detail>()))
          as asyncc.Future<Either<Failure, Detail>>);
}
