import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'geofence_event.dart';
part 'geofence_state.dart';

class GeofenceBloc extends Bloc<GeofenceEvent, GeofenceState> {
  GeofenceBloc() : super(GeofenceInitial());

  @override
  Stream<GeofenceState> mapEventToState(
    GeofenceEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
