import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/domain/usecases/get_favorite_restaurant.dart';
import 'package:restaurant_app/core/domain/usecases/get_favorite_status.dart';
import 'package:restaurant_app/core/domain/usecases/remove_favorite.dart';
import 'package:restaurant_app/core/domain/usecases/save_favorite.dart';
import 'package:restaurant_app/ui/bloc/favorite/favorite_event.dart';
import 'package:restaurant_app/ui/bloc/favorite/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteRestaurant _getFavoriteRestaurant;
  final GetFavoriteStatus _getFavoriteStatus;
  final RemoveFavoriteList _removeFavorite;
  final SaveFavorite _saveFavorite;

  FavoriteBloc(
    this._getFavoriteRestaurant,
    this._getFavoriteStatus,
    this._removeFavorite,
    this._saveFavorite,
  ) : super(FavoriteInitial()) {
    on<OnFetchFavorite>(_onFetchFavorite);
    on<FetchFavoriteStatus>(_fetchFavoriteStatus);
    on<AddFavorite>(_addMovieToFavorite);
    on<RemoveFavorite>(_removeFavoriteList);
  }

  FutureOr<void> _onFetchFavorite(
    OnFetchFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());

    final result = await _getFavoriteRestaurant.execute();

    result.fold(
        (l) => emit(FavoriteError(l.message)), (r) => emit(FavoriteLoaded(r)));
  }

  FutureOr<void> _fetchFavoriteStatus(
    FetchFavoriteStatus event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    final id = event.id;
    final result = await _getFavoriteStatus.execute(id);

    emit(IsAddedToFavorite(result));
  }

  FutureOr<void> _addMovieToFavorite(
    AddFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    final detail = event.detail;

    final result = await _saveFavorite.execute(detail);

    result.fold(
      (failure) {
        emit(FavoriteError(failure.message));
      },
      (message) {
        emit(FavoriteMessage(message));
      },
    );
  }

  FutureOr<void> _removeFavoriteList(
    RemoveFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    final movie = event.detail;

    final result = await _removeFavorite.execute(movie);

    result.fold(
      (failure) {
        emit(FavoriteError(failure.message));
      },
      (message) {
        emit(FavoriteMessage(message));
      },
    );
  }
}
