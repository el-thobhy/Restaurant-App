import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/domain/usecases/get_favorite_restaurant.dart';
import 'package:restaurant_app/ui/bloc/favorite/favorite_event.dart';
import 'package:restaurant_app/ui/bloc/favorite/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteRestaurant _getFavoriteRestaurant;

  FavoriteBloc(this._getFavoriteRestaurant) : super(FavoriteInitial()) {
    on<OnFetchFavorite>(_onFetchFavorite);
  }

  FutureOr<void> _onFetchFavorite(
    OnFetchFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());

    final result = await _getFavoriteRestaurant.execute();

    result.fold(
        (failure) => emit(FavoriteError(failure.message)),
        (data) =>
            data.isEmpty ? emit(FavoriteEmpty()) : emit(FavoriteLoaded(data)));
  }
}
