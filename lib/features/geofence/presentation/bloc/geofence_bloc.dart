import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:setel_geofanc/core/app_utils.dart';
import 'package:setel_geofanc/features/geofence/domain/usecases/export_uc.dart';

part 'geofence_event.dart';
part 'geofence_state.dart';

class GeofenceBloc extends Bloc<GeofenceEvent, GeofenceState> {
  final GeofenceUC geofenceUC;
  final SaveWifiSsidUC saveWifiSsidUC;
  final SaveCicleUC saveCicleUC;
  final InputConverter inputConverter;

  GeofenceBloc({
    this.geofenceUC,
    this.saveWifiSsidUC,
    this.saveCicleUC,
    this.inputConverter,
  }) : super(GeofenceInitial());

  @override
  Stream<GeofenceState> mapEventToState(
    GeofenceEvent event,
  ) async* {
    if (event is SaveWifiSsidEvent) {
      final saveResult = await saveWifiSsidUC(wifiSSID: event.wifiSsid);
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
    } else if (event is SaveCircleEvent) {
      //check first if the numbers are double accepted
      final inputEither = inputConverter.stringToUnsignedDouble(
        radius: event.radius,
        xPoint: event.xPoint,
        yPoint: event.yPoint,
      );

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: failure.message);
        },
        (tuple3) async* {
          final saveResult = await saveCicleUC(
            params: CircleParams(
              xPoint: tuple3.value1,
              yPoint: tuple3.value2,
              radius: tuple3.value3,
            ),
          );
          yield saveResult.fold(
            (l) => Error(message: l.message),
            (r) => SuccessSaveWifiState(message: r),
          );
        },
      );
    }
  }
}
