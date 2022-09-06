part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {}

class OnDetailCalled extends DetailEvent {
  final String id;

  OnDetailCalled(this.id);
  @override
  List<Object> get props => [id];
}

class FetchFavoriteStatus extends DetailEvent {
  final String id;

  FetchFavoriteStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddFavorite extends DetailEvent {
  final Detail detail;

  AddFavorite(this.detail);

  @override
  List<Object> get props => [detail];
}

class RemoveFavorite extends DetailEvent {
  final Detail detail;

  RemoveFavorite(this.detail);

  @override
  List<Object> get props => [detail];
}
