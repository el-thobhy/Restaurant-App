import 'package:bloc/bloc.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/services/api_services.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(InitialDetail()) {
    on<GetDetail>((event, emit) async {
      emit(DetailLoading());
      var resto = await ApiServices().getDetailRestaurant(event.id);
      if (resto.error != true) {
        emit(DetailLoaded(detail: resto.restaurant!));
      } else {
        emit(DetailError(resto.message));
      }
    });
  }
}
