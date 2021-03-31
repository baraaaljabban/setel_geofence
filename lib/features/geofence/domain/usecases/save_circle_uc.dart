import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:setel_geofanc/core/use_cases.dart';
import 'package:setel_geofanc/error/failures.dart';
import 'package:setel_geofanc/features/geofence/domain/repository/geofence_repository.dart';

class SaveCicleUC extends UseCase<String, CicleParams> {
  final GeofenceRepository geofenceRepository;

  SaveCicleUC({@required this.geofenceRepository});

  @override
  Future<Either<Failure, String>> call({CicleParams params}) async {
    return await geofenceRepository.saveCircleConfig(
      xPoint: params.xPoint,
      yPoint: params.yPoint,
      radius: params.radius,
    );
  }
}

class CicleParams {
  final double xPoint, yPoint, radius;
  CicleParams({
    @required this.xPoint,
    @required this.yPoint,
    @required this.radius,
  });
}
