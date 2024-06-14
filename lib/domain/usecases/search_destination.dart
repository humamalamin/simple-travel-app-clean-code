import 'package:course_travel/core/error/failures.dart';
import 'package:course_travel/domain/entities/destination_entity.dart';
import 'package:course_travel/domain/repositories/destination_repository.dart';
import 'package:dartz/dartz.dart';

class SearchDestinationUsecase {
  final DestinationRepository _repository;

  SearchDestinationUsecase(this._repository);

  Future<Either<Failure, List<DestinationEntity>>> call(String query) {
    return _repository.search(query);
  }
}