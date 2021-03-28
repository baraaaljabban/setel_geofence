import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:setel_geofanc/features/geofence/domain/usecases/geofence_uc.dart';

part 'geofence_event.dart';
part 'geofence_state.dart';

class GeofenceBloc extends Bloc<GeofenceEvent, GeofenceState> {
  final GeofenceUC geofenceUC;
  final SaveWifiSsidUC saveWifiSsidUC;

  GeofenceBloc({
    this.geofenceUC,
    this.saveWifiSsidUC,
  }) : super(GeofenceInitial());

  @override
  Stream<GeofenceState> mapEventToState(
    GeofenceEvent event,
  ) async* {
    if (event is SaveWifiSsidEvent) {
      final saveResult = await saveWifiSsidUC();
      yield saveResult.fold(
        (l) => Error(message: l.message),
        (r) => SuccessSaveWifiState(message: r),
      );
    } else if (event is IsInsideEvent) {
      final isInisde = await geofenceUC();
      yield isInisde.fold(
        (l) => Error(message: l.message),
        (r) => IsInsideState(isInisde: r),
      );
    }
  }
}
