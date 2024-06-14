import 'package:course_travel/domain/entities/destination_entity.dart';
import 'package:course_travel/domain/usecases/get_all_destination.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_destination_bloc_event.dart';
part 'all_destination_bloc_state.dart';

class AllDestinationBlocBloc extends Bloc<AllDestinationBlocEvent, AllDestinationBlocState> {
  final GetAllDestinationUsecase _useCase;

  AllDestinationBlocBloc(this._useCase) : super(AllDestinationBlocInitial()) {
    on<OnGetAllDestination>((event, emit) async {
      emit(AllDestinationBlocLoading());
      final result = await _useCase.call();
      result.fold(
        (failure) => emit(AllDestinationBlocFailure(message: failure.message)),
        (data) => emit(AllDestinationBlocLoaded(data: data)));
    });
  }
}
