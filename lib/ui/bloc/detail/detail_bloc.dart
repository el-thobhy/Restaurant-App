import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/domain/entities/detail.dart';
import 'package:restaurant_app/core/domain/usecases/get_detail.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetail _getDetail;

  DetailBloc(this._getDetail) : super(DetailEmpty()) {
    on<OnDetailCalled>(_onDetailCalled);
  }

  FutureOr<void> _onDetailCalled(
    OnDetailCalled event,
    Emitter<DetailState> emit,
  ) async {
    final id = event.id;

    emit(DetailLoading());

    final result = await _getDetail.execute(id);

    result.fold((failure) {
      emit(DetailError(failure.message));
    }, (data) {
      emit(DetailLoaded(detail: data));
    });
  }
}
