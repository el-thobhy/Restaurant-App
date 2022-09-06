import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/core/common/failure.dart';
import 'package:restaurant_app/ui/bloc/list/restaurant_bloc.dart';
import 'package:restaurant_app/ui/bloc/list/restaurant_state.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetRestaurant usecase;
  late RestaurantBloc resto;

  setUp(
    () {
      usecase = MockGetRestaurant();
      resto = RestaurantBloc(usecase);
    },
  );

  test(
    'the initial state should be empty',
    () {
      expect(
        resto.state,
        RestaurantEmpty(),
      );
    },
  );

  blocTest<RestaurantBloc, RestaurantState>(
    'should emit loading state and then loaded data state when success',
    build: () {
      when(usecase.execute()).thenAnswer(
        (_) async => Right(testRestaurantList),
      );
      return resto;
    },
    act: (bloc) => bloc.add(
      OnFetchGetRestaurant(),
    ),
    expect: () => [
      RestaurantLoading(),
      RestaurantLoaded(testRestaurantList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnFetchGetRestaurant().props;
    },
  );

  blocTest<RestaurantBloc, RestaurantState>(
    'should emit loading state and return error state when fail to fetch data',
    build: () {
      when(usecase.execute()).thenAnswer(
        (_) async => const Left(
          ServerFailure('Network Error'),
        ),
      );
      return resto;
    },
    act: (bloc) => bloc.add(
      OnFetchGetRestaurant(),
    ),
    expect: () => [
      RestaurantLoading(),
      const RestaurantError('Network Error'),
    ],
    verify: (bloc) => RestaurantLoading(),
  );

  blocTest<RestaurantBloc, RestaurantState>(
    'should emit loading state and then empty state when data is empty',
    build: () {
      when(usecase.execute()).thenAnswer(
        (_) async => const Right([]),
      );
      return resto;
    },
    act: (bloc) => bloc.add(
      OnFetchGetRestaurant(),
    ),
    expect: () => [
      RestaurantLoading(),
      RestaurantEmpty(),
    ],
  );
}
