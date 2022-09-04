import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/domain/entities/search.dart';
import 'package:restaurant_app/core/domain/usecases/get_search.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearch _search;

  SearchBloc(this._search) : super(SearchInitial()) {
    on<OnQueryChange>(_onQueryChange);
  }
  FutureOr<void> _onQueryChange(
      OnQueryChange event, Emitter<SearchState> emit) async {
    final query = event.query;
    emit(SearchLoading());

    final result = await _search.execute(query);

    result.fold(
      (failure) {
        emit(SearchError(message: failure.message));
      },
      (data) {
        data.isEmpty ? emit(SearchEmpty()) : emit(SearchLoaded(result: data));
      },
    );
  }

  @override
  Stream<SearchState> get stream =>
      super.stream.debounceTime(const Duration(milliseconds: 200));
}
