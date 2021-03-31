import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:setel_geofanc/core/network_info.dart';
import 'package:setel_geofanc/features/geofence/data/datasource/geofence_local_datasource.dart';
import 'package:setel_geofanc/features/geofence/data/repository/geofence_repo_impl.dart';
import 'package:setel_geofanc/features/geofence/domain/repository/geofence_repository.dart';
import 'package:setel_geofanc/features/geofence/domain/usecases/export_uc.dart';
import 'package:setel_geofanc/features/geofence/domain/usecases/geofence_uc.dart';
import 'package:setel_geofanc/features/geofence/presentation/bloc/geofence_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => DataConnectionChecker());
  sl.registerFactory(() => Connectivity());
  sl.registerFactory(() => WifiInfo());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: sl(),
      dataConnectionChecker: sl(),
    ),
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  /// register Geofence Bloc and all other Depindicis
  sl.registerLazySingleton<GeofenceLocalDataSource>(
      () => GeofenceLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<GeofenceRepository>(() => GeofenceRepositoryImpl(
        localDataSource: sl(),
        wifiInfo: sl(),
        // connectivity: sl(),
      ));
  sl.registerFactory(() => GeofenceUC(geofenceRepository: sl()));
  sl.registerFactory(() => SaveWifiSsidUC(geofenceRepository: sl()));
  sl.registerFactory(() => SaveCicleUC(geofenceRepository: sl()));

  sl.registerFactory(() => GeofenceBloc(
        geofenceUC: sl(),
        saveWifiSsidUC: sl(),
        saveCicleUC: sl(),
      ));
}
