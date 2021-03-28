import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:setel_geofanc/core/Strings/cash_strings.dart';
import 'package:setel_geofanc/error/exceptions.dart';
import 'package:setel_geofanc/error/failuer_string.dart';
import 'package:setel_geofanc/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:setel_geofanc/features/geofence/data/datasource/geofence_local_datasource.dart';
import 'package:setel_geofanc/features/geofence/domain/repository/geofence_repository.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'dart:developer' as developer;

class GeofenceRepositoryImpl extends GeofenceRepository {
  final GeofenceLocalDataSource localDataSource;
  final WifiInfo wifiInfo;
  GeofenceRepositoryImpl({
    this.localDataSource,
    this.wifiInfo,
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
  Future<Either<Failure, String>> saveWifiSsid() async {
    return await saveCurrentWifiSsid();
  }

  Future<Either<Failure, String>> saveCurrentWifiSsid() async {
    String wifiName = "";
    try {
      if (!kIsWeb && Platform.isIOS) {
        LocationAuthorizationStatus status =
            await wifiInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await wifiInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await wifiInfo.getWifiName();
        } else {
          wifiName = await wifiInfo.getWifiName();
        }
      } else {
        wifiName = await wifiInfo.getWifiName();
      }
      return Right(WE_SAVED_YOUR_WIFI + "$wifiName");
    } on PlatformException catch (e) {
      developer.log(e.toString());
      return Left(UnknownFailuer(message: COULD_NOT_GET_WITI_NAME));
    }
  }
}
