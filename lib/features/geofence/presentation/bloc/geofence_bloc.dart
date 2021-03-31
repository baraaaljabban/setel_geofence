import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:setel_geofanc/features/geofence/domain/usecases/export_uc.dart';

part 'geofence_event.dart';
part 'geofence_state.dart';

class GeofenceBloc extends Bloc<GeofenceEvent, GeofenceState> {
  final GeofenceUC geofenceUC;
  final SaveWifiSsidUC saveWifiSsidUC;
  final SaveCicleUC saveCicleUC;
  GeofenceBloc({
    this.geofenceUC,
    this.saveWifiSsidUC,
    this.saveCicleUC,
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
