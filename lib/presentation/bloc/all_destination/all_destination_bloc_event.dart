part of 'all_destination_bloc_bloc.dart';

sealed class AllDestinationBlocEvent extends Equatable {
  const AllDestinationBlocEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllDestination extends AllDestinationBlocEvent {}