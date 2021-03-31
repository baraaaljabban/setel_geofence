import 'package:setel_geofanc/core/Strings/export_strings.dart';
import 'package:setel_geofanc/core/app_utils.dart';
import 'package:setel_geofanc/error/exceptions.dart';
import 'package:setel_geofanc/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:setel_geofanc/features/geofence/data/datasource/geofence_local_datasource.dart';
import 'package:setel_geofanc/features/geofence/domain/repository/geofence_repository.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

class GeofenceRepositoryImpl extends GeofenceRepository {
  final GeofenceLocalDataSource localDataSource;
  final WifiInfo wifiInfo;
  // final Connectivity connectivity;
  GeofenceRepositoryImpl({
    this.localDataSource,
    this.wifiInfo,
    // this.connectivity,
  });
  @override
  Future<Either<Failure, String>> getSavedWifiSsid() async {
    try {
      return Right(localDataSource.getSavedWifiSsid());
    } on CacheException catch (_) {
      return Left(CacheFailure(message: NO_SAVED_WIFI_FOUND));
    }
  }

  @override
  Future<Either<Failure, bool>> isInsideGeofence(
      {double xPoint, double yPoint}) {}

  @override
  Future<Either<Failure, String>> saveWifiSsid({
    String wifiSSID,
  }) async {
    if (wifiSSID == null || wifiSSID.isEmpty)
      return await saveCurrentWifiSsid(wifiInfo: wifiInfo);
    else {
      try {
        localDataSource.saveWifiSsid(wifiName: wifiSSID);
        return Right(WE_SAVED_YOUR_WIFI + "$wifiSSID");
      } on CacheException catch (_) {
        return Left(CacheFailure(message: SOME_THING_WENT_WROING));
      }
    }
  }

  @override
  Future<Either<Failure, String>> saveCircleConfig(
      {double xPoint, double yPoint, double radius}) async {
    try {
      localDataSource.saveCircleConfig(
        xPoint: xPoint,
        yPoint: yPoint,
        radius: radius,
      );
      return Right(WE_SAVED_YOUR_CIRCLE);
    } on CacheException catch (_) {
      return Left(CacheFailure(message: COULDNT_SAVE_CIRCLE));
    }
  }
}
