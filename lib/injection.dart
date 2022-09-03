import 'package:get_it/get_it.dart';
import 'package:restaurant_app/bloc/list/restaurant_bloc.dart';
import 'package:restaurant_app/core/data/datasources/db/database_helper.dart';
import 'package:restaurant_app/core/data/datasources/remote_data_source.dart';
import 'package:restaurant_app/core/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurant_app/core/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_app/core/domain/usecases/get_restaurant.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(() => RestaurantBloc(locator()));

  //useCase
  locator.registerLazySingleton(() => GetRestaurant(locator()));

  //repositories
  locator.registerLazySingleton<RestaurantRepository>(
      () => RestaurantRepositoryImpl(remoteDataSource: locator()));

  //data sources
  locator.registerLazySingleton<RestaurantRemoteDataSource>(
      () => RestaurantRemoteDataSourceImpl());

  //helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
