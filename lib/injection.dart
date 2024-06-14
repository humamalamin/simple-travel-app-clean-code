import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:course_travel/core/platform/network_info.dart';
import 'package:course_travel/data/datasources/destination_local_datasource.dart';
import 'package:course_travel/data/datasources/destination_remote_datasource.dart';
import 'package:course_travel/data/repositories/destination_repository_impl.dart';
import 'package:course_travel/domain/repositories/destination_repository.dart';
import 'package:course_travel/domain/usecases/get_all_destination.dart';
import 'package:course_travel/domain/usecases/search_destination.dart';
import 'package:course_travel/domain/usecases/top_destination.dart';
import 'package:course_travel/presentation/bloc/all_destination/all_destination_bloc_bloc.dart';
import 'package:course_travel/presentation/bloc/search_destination/search_destination_bloc.dart';
import 'package:course_travel/presentation/bloc/top_destination/top_destination_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // bloc
  locator.registerFactory(() => AllDestinationBlocBloc(locator()));
  locator.registerFactory(() => TopDestinationBloc(locator()));
  locator.registerFactory(() => SearchDestinationBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetAllDestinationUsecase(locator()));
  locator.registerLazySingleton(() => TopDestinationUsecase(locator()));
  locator.registerLazySingleton(() => SearchDestinationUsecase(locator()));

  // repository
  locator.registerLazySingleton<DestinationRepository>(() => DestinationRepositoryImpl(
    networkInfo: locator(),
    localDatasource: locator(),
    remoteDatasource: locator()
    ));
  

  // data source
  locator.registerLazySingleton<DestinationLocalDatasource>(() => DestinationLocalDatasourceImpl(pref: locator()));
  locator.registerLazySingleton<DestinationRemoteDatasource>(() => DestincationRemoterDarasourceImpl(client: locator()));


  // platform
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: locator()));

  // external
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());
}