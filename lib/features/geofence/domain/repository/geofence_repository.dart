import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:setel_geofanc/error/failures.dart';

/// [GeofenceRepository] [class] has 3 main functions 
/// 
///(1) `isInsideGeofence` : takes 2 [paarams] [x],[y] and return [Either] if the point is inside or out side or [Failure] for any kind of reasons
///  
///(2) `saveWifiSsid` : to save the wifi SSID taks one [Params] : [WifiName]
///
///(3) `getSavedWifiSsid`: return [Either] : -> [String] saved wifi or -> [Failure] if not found
abstract class GeofenceRepository {
  Future<Either<Failure, bool>> isInsideGeofence({
    @required double xPoint,
    @required double yPoint,
  });
  Future<void> saveWifiSsid({@required String wifiName});
  Future<Either<Failure, String>> getSavedWifiSsid();
}
