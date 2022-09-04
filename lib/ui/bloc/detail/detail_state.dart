part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();
}

class DetailEmpty extends DetailState {
  @override
  List<Object> get props => [];
}

class DetailLoading extends DetailState {
  @override
  List<Object> get props => [];
}

class DetailLoaded extends DetailState {
  final Detail detail;

  const DetailLoaded({required this.detail});

  @override
  List<Object> get props => [detail];
}

class DetailError extends DetailState {
  final String message;

  const DetailError(this.message);

  @override
  List<Object?> get props => [message];
}
