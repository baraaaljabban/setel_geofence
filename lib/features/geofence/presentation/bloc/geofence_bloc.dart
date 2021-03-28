import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:setel_geofanc/features/geofence/domain/usecases/geofence_uc.dart';

part 'geofence_event.dart';
part 'geofence_state.dart';

class GeofenceBloc extends Bloc<GeofenceEvent, GeofenceState> {
  final GeofenceUC geofenceUC;
  GeofenceBloc({this.geofenceUC}) : super(GeofenceInitial());

  @override
  Stream<GeofenceState> mapEventToState(
    GeofenceEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
