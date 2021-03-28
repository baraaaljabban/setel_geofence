import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:setel_geofanc/core/use_cases.dart';
import 'package:setel_geofanc/error/failures.dart';
import 'package:setel_geofanc/features/geofence/domain/repository/geofence_repository.dart';

class GeofenceUC extends UseCaseNoParams {
  final GeofenceRepository geofenceRepository;

  GeofenceUC({@required this.geofenceRepository});
  @override
  Future<Either<Failure, dynamic>> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}

