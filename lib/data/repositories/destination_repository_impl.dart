import 'dart:async';
import 'dart:io';

import 'package:course_travel/core/error/exception.dart';
import 'package:course_travel/core/error/failures.dart';
import 'package:course_travel/core/platform/network_info.dart';
import 'package:course_travel/data/datasources/destination_local_datasource.dart';
import 'package:course_travel/data/datasources/destination_remote_datasource.dart';
import 'package:course_travel/domain/entities/destination_entity.dart';
import 'package:course_travel/domain/repositories/destination_repository.dart';
import 'package:dartz/dartz.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final NetworkInfo networkInfo;
  final DestinationLocalDatasource localDatasource;
  final DestinationRemoteDatasource remoteDatasource;

  DestinationRepositoryImpl({required this.networkInfo, required this.localDatasource, required this.remoteDatasource});

  @override
  Future<Either<Failure, List<DestinationEntity>>> all() async{
    bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDatasource.all();
        await localDatasource.cacheAll(result);
        return Right(result.map((e) => e.toEntity).toList());
      } on NotFoundException {
        return const Left(NotFoundFailure('Data tidak ditemukan'));
      } on ServerException {
        return const Left(ServerFailure('Server error'));
      } on TimeoutException {
        return const Left(TimeoutFailure('Time Out. No response'));
      }
    } else {
      try {
        final result = await localDatasource.getAll();
        return Right(result.map((e) => e.toEntity).toList());
      } on CachedException {
        return const Left(CachedFailure('Data is not present'));
      }
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> search(String query) async{
    try {
      final result = await remoteDatasource.search(query);
      await localDatasource.cacheAll(result);
      return Right(result.map((e) => e.toEntity).toList());
    } on NotFoundException {
      return const Left(NotFoundFailure('Data tidak ditemukan'));
    } on ServerException {
      return const Left(ServerFailure('Server error'));
    } on TimeoutException {
      return const Left(TimeoutFailure('Time Out. No response'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to network'));
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> top() async{
    try {
      final result = await remoteDatasource.top();
      await localDatasource.cacheAll(result);
      return Right(result.map((e) => e.toEntity).toList());
    } on NotFoundException {
      return const Left(NotFoundFailure('Data tidak ditemukan'));
    } on ServerException {
      return const Left(ServerFailure('Server error'));
    } on TimeoutException {
      return const Left(TimeoutFailure('Time Out. No response'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to network'));
    }
  }
}