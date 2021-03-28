import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:setel_geofanc/core/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => DataConnectionChecker());
  sl.registerFactory(() => Connectivity());

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: sl(),
      dataConnectionChecker: sl(),
    ),
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  /// register Geofence Bloc and all other Depindicis
  sl.registerLazySingleton<GeofenceRepository>(() => GeofenceRepositoryImpl());
  sl.registerFactory(() => GeofenceUC(GeofenceRepository: sl()));
  sl.registerFactory(() => GeofenceBloc(GeofenceUC: sl()));
}
