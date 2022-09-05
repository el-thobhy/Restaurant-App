part of 'detail_bloc.dart';

@immutable
class DetailState extends Equatable {
  final Detail? detail;
  final String message;
  final RequestState detailState;
  final String favoriteMessage;
  final bool isAddedTofavorite;

  const DetailState({
    required this.detail,
    required this.message,
    required this.detailState,
    required this.favoriteMessage,
    required this.isAddedTofavorite,
  });

  DetailState copyWith({
    Detail? detail,
    String? message,
    RequestState? detailState,
    String? favoriteMessage,
    bool? isAddedToFavorite,
  }) {
    return DetailState(
      detail: detail ?? this.detail,
      message: message ?? this.message,
      detailState: detailState ?? this.detailState,
      favoriteMessage: favoriteMessage ?? this.favoriteMessage,
      isAddedTofavorite: isAddedToFavorite ?? isAddedTofavorite,
    );
  }

  factory DetailState.initial() {
    return const DetailState(
      detail: null,
      message: '',
      detailState: RequestState.empty,
      favoriteMessage: '',
      isAddedTofavorite: false,
    );
  }

  @override
  List<Object?> get props =>
      [detail, message, detailState, favoriteMessage, isAddedTofavorite];
}
