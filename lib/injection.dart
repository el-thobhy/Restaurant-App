import 'package:get_it/get_it.dart';
import 'package:restaurant_app/core/common/http_client.dart';
import 'package:restaurant_app/core/data/datasources/db/database_helper.dart';
import 'package:restaurant_app/core/data/datasources/local_data_source.dart';
import 'package:restaurant_app/core/data/datasources/remote_data_source.dart';
import 'package:restaurant_app/core/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurant_app/core/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_app/core/domain/usecases/get_detail.dart';
import 'package:restaurant_app/core/domain/usecases/get_favorite_restaurant.dart';
import 'package:restaurant_app/core/domain/usecases/get_favorite_status.dart';
import 'package:restaurant_app/core/domain/usecases/get_restaurant.dart';
import 'package:restaurant_app/core/domain/usecases/get_search.dart';
import 'package:restaurant_app/core/domain/usecases/remove_favorite.dart';
import 'package:restaurant_app/core/domain/usecases/save_favorite.dart';
import 'package:restaurant_app/ui/bloc/detail/detail_bloc.dart';
import 'package:restaurant_app/ui/bloc/favorite/favorite_bloc.dart';
import 'package:restaurant_app/ui/bloc/list/restaurant_bloc.dart';
import 'package:restaurant_app/ui/bloc/schedule/schedule_cubit.dart';
import 'package:restaurant_app/ui/bloc/search/search_bloc.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(() => RestaurantBloc(locator()));
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(
      () => DetailBloc(locator(), locator(), locator(), locator()));
  locator.registerFactory(() => FavoriteBloc(locator()));
  locator.registerFactory(() => ScheduleCubit());

  //useCase
  locator.registerLazySingleton(() => GetRestaurant(locator()));
  locator.registerLazySingleton(() => GetSearch(locator()));
  locator.registerLazySingleton(() => GetDetail(locator()));
  locator.registerLazySingleton(() => GetFavoriteRestaurant(locator()));
  locator.registerLazySingleton(() => GetFavoriteStatus(locator()));
  locator.registerLazySingleton(() => SaveFavorite(locator()));
  locator.registerLazySingleton(() => RemoveFavoriteList(locator()));

  //repositories
  locator.registerLazySingleton<RestaurantRepository>(() =>
      RestaurantRepositoryImpl(
          remoteDataSource: locator(), localDataSource: locator()));

  //data sources
  locator.registerLazySingleton<RestaurantRemoteDataSource>(
      () => RestaurantRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<RestauranLocalDataSource>(
      () => RestaurantLocalDataSourceImpl(helper: locator()));

  //helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  //client
  locator.registerLazySingleton(() => HttpClientInit.client);
}
