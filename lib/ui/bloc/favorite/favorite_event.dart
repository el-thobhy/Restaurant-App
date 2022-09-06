import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FavoriteEvent extends Equatable {}

class OnFetchFavorite extends FavoriteEvent {
  @override
  List<Object> get props => [];
}
