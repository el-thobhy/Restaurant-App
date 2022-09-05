import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/core/domain/entities/detail.dart';

@immutable
abstract class FavoriteEvent extends Equatable {}

class OnFetchFavorite extends FavoriteEvent {
  @override
  List<Object> get props => [];
}

class FetchFavoriteStatus extends FavoriteEvent {
  final String id;

  FetchFavoriteStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddFavorite extends FavoriteEvent {
  final Detail detail;

  AddFavorite(this.detail);

  @override
  List<Object> get props => [detail];
}

class RemoveFavorite extends FavoriteEvent {
  final Detail detail;

  RemoveFavorite(this.detail);

  @override
  List<Object> get props => [detail];
}
