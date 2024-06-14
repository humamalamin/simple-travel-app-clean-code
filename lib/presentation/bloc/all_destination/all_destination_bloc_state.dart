part of 'all_destination_bloc_bloc.dart';

sealed class AllDestinationBlocState extends Equatable {
  const AllDestinationBlocState();
  
  @override
  List<Object> get props => [];
}

final class AllDestinationBlocInitial extends AllDestinationBlocState {}

final class AllDestinationBlocLoading extends AllDestinationBlocState {}

final class AllDestinationBlocFailure extends AllDestinationBlocState {
  final String message;

  const AllDestinationBlocFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class AllDestinationBlocLoaded extends AllDestinationBlocState {
  final List<DestinationEntity> data;

  const AllDestinationBlocLoaded({required this.data});

  @override
  List<Object> get props => [data];
}
