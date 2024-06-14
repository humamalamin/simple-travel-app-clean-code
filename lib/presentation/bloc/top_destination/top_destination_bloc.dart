import 'package:course_travel/domain/entities/destination_entity.dart';
import 'package:course_travel/domain/usecases/top_destination.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_destination_event.dart';
part 'top_destination_state.dart';

class TopDestinationBloc extends Bloc<TopDestinationEvent, TopDestinationState> {
  final TopDestinationUsecase _useCase;

  TopDestinationBloc(this._useCase) : super(TopDestinationInitial()) {
    on<TopDestinationEvent>((event, emit) async{
      emit(TopDestinationLoading());
      final result = await _useCase();
      result.fold(
        (failure) => emit(TopDestinationFailure(message: failure.message)),
        (data) => emit(TopDestinationLoaded(data: data)));
    });
  }
}
