import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';

@immutable
abstract class FavoriteState extends Equatable {}

class FavoriteInitial extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteEmpty extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteLoaded extends FavoriteState {
  final List<Restaurant> result;

  FavoriteLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class IsAddedToFavorite extends FavoriteState {
  final bool isAdded;

  IsAddedToFavorite(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class FavoriteMessage extends FavoriteState {
  final String message;

  FavoriteMessage(this.message);

  @override
  List<Object> get props => [message];
}
