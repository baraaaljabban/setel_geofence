import 'dart:math';

import 'package:setel_geofanc/core/Strings/export_strings.dart';
import 'package:setel_geofanc/core/app_utils.dart';
import 'package:setel_geofanc/error/exceptions.dart';
import 'package:setel_geofanc/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:setel_geofanc/features/geofence/data/datasource/geofence_local_datasource.dart';
import 'package:setel_geofanc/features/geofence/data/model/circle_model.dart';
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
      {double xPoint, double yPoint}) async {
    try {
      final sotredCircle = localDataSource.getCircleConfig();
      final sotredWifi = localDataSource.getSavedWifiSsid();
      final currentWifi = await currentWifiSSID(wifiInfo: wifiInfo);
      if (currentWifi == null || currentWifi.isEmpty)
        return Left(UnknownFailuer(message: "please connect to WIFI"));
      if (sotredWifi == currentWifi)
        return Right(true);
      else {
        double dx = (xPoint - sotredCircle.xPoint).abs();
        double dy = (yPoint - sotredCircle.yPoint).abs();
        double r = sotredCircle.radius;

        if (dx + dy <= r) return Right(true);
        if (dx > r) return Right(false);
        if (dy > r) return Right(false);
        if (pow(dx, 2) + pow(dy, 2) <= pow(r, 2))
          return Right(true);
        else
          return Right(false);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> saveWifiSsid({
    String wifiSSID,
  }) async {
    // TODO : refactor
    if (wifiSSID == null || wifiSSID.isEmpty) {
      final result = await saveCurrentWifiSsid(wifiInfo: wifiInfo);
      result.fold(
        (l) => null,
        (r) => localDataSource.saveWifiSsid(wifiName: r),
      );
      return result;
    } else {
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

  @override
  Future<Either<Failure, CircleModel>> getCircleConfig() async {
    try {
      return Right(localDataSource.getCircleConfig());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
