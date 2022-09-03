part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class GetDetail extends DetailEvent {
  final String id;

  const GetDetail({required this.id});
  @override
  List<Object> get props => [id];
}
