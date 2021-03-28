import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:setel_geofanc/core/use_cases.dart';
import 'package:setel_geofanc/error/failures.dart';
import 'package:setel_geofanc/features/geofence/domain/repository/geofence_repository.dart';

class GeofenceUC extends UseCase<bool, GeofenceParams> {
  final GeofenceRepository geofenceRepository;

  GeofenceUC({@required this.geofenceRepository});

  @override
  Future<Either<Failure, bool>> call({GeofenceParams params}) {
    return geofenceRepository.isInsideGeofence(
      xPoint: params.xPoint,
      yPoint: params.yPoint,
    );
  }
}

class SaveWifiSsidUC extends UseCaseNoParams {
  final GeofenceRepository geofenceRepository;
  SaveWifiSsidUC({@required this.geofenceRepository});

  @override
  Future<Either<Failure, String>> call() async {
    return await geofenceRepository.saveWifiSsid();
  }
}

class GeofenceParams {
  final double xPoint, yPoint;
  GeofenceParams({
    @required this.xPoint,
    @required this.yPoint,
  });
}
