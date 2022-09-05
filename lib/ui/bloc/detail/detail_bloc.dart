import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/core/common/constants.dart';
import 'package:restaurant_app/core/common/state_enum.dart';
import 'package:restaurant_app/core/domain/entities/detail.dart';
import 'package:restaurant_app/core/domain/usecases/get_detail.dart';
import 'package:restaurant_app/core/domain/usecases/get_favorite_status.dart';
import 'package:restaurant_app/core/domain/usecases/remove_favorite.dart';
import 'package:restaurant_app/core/domain/usecases/save_favorite.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetail _getDetail;
  final GetFavoriteStatus _getFavoriteStatus;
  final RemoveFavoriteList _removeFavorite;
  final SaveFavorite _saveFavorite;

  DetailBloc(
    this._getDetail,
    this._getFavoriteStatus,
    this._removeFavorite,
    this._saveFavorite,
  ) : super(DetailState.initial()) {
    on<OnDetailCalled>(_onDetailCalled);
    on<FetchFavoriteStatus>(_fetchFavoriteStatus);
    on<RemoveFavorite>(_removeFavoriteList);
    on<AddFavorite>(_addToFavorite);
  }

  FutureOr<void> _onDetailCalled(
    OnDetailCalled event,
    Emitter<DetailState> emit,
  ) async {
    final id = event.id;

    emit(state.copyWith(detailState: RequestState.loading));

    final result = await _getDetail.execute(id);

    result.fold((failure) {
      emit(state.copyWith(detailState: RequestState.error));
    }, (data) {
      emit(state.copyWith(
          detailState: RequestState.loaded, detail: data, message: ''));
    });
  }

  FutureOr<void> _fetchFavoriteStatus(
    FetchFavoriteStatus event,
    Emitter<DetailState> emit,
  ) async {
    final result = await _getFavoriteStatus.execute(event.id);

    emit(state.copyWith(isAddedToFavorite: result));
  }

  FutureOr<void> _addToFavorite(
    AddFavorite event,
    Emitter<DetailState> emit,
  ) async {
    final result = await _saveFavorite.execute(event.detail);

    result.fold(
      (failure) {
        emit(state.copyWith(favoriteMessage: failure.message));
      },
      (message) {
        emit(state.copyWith(favoriteMessage: bookmarkAddSourceMessage));
      },
    );

    add(FetchFavoriteStatus(event.detail.id));
  }

  FutureOr<void> _removeFavoriteList(
    RemoveFavorite event,
    Emitter<DetailState> emit,
  ) async {
    final movie = event.detail;

    final result = await _removeFavorite.execute(movie);

    result.fold(
      (failure) {
        emit(state.copyWith(favoriteMessage: failure.message));
      },
      (message) {
        emit(state.copyWith(favoriteMessage: bookmarkAddSourceMessage));
      },
    );
    add(FetchFavoriteStatus(event.detail.id));
  }
}
