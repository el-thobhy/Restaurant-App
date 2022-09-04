part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class OnDetailCalled extends DetailEvent {
  final String id;

  const OnDetailCalled({required this.id});
  @override
  List<Object> get props => [id];
}
