import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:setel_geofanc/error/failures.dart';

abstract class GeofenceRepository {
  Future<Either<Failure, bool>> isInsideGeofence();
  Future<void> saveWifiSsid({@required String wifiName});
  Future<Either<Failure, String>> getWifiSsid();
}
