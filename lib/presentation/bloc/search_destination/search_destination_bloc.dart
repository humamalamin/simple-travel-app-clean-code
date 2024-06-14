import 'package:course_travel/domain/entities/destination_entity.dart';
import 'package:course_travel/domain/usecases/search_destination.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_destination_event.dart';
part 'search_destination_state.dart';

class SearchDestinationBloc extends Bloc<SearchDestinationEvent, SearchDestinationState> {
  final SearchDestinationUsecase _useCase;

  SearchDestinationBloc(this._useCase) : super(SearchDestinationInitial()) {
    on<SearchDestinationEvent>((event, emit) async{
      emit(SearchDestinationLoading());
      final result = await _useCase(event.toString());
      result.fold(
        (failure) => emit(SearchDestinationFailure(message: failure.message)),
        (data) => emit(SearchDestinationLoaded(data: data)));
    });
  }
}
