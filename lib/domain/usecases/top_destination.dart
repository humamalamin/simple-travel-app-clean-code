import 'package:course_travel/core/error/failures.dart';
import 'package:course_travel/domain/entities/destination_entity.dart';
import 'package:course_travel/domain/repositories/destination_repository.dart';
import 'package:dartz/dartz.dart';

class TopDestinationUsecase {
  final DestinationRepository _repository;

  TopDestinationUsecase(this._repository);

  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _repository.top();
  }
}