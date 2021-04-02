part of 'geofence_bloc.dart';

@immutable
abstract class GeofenceEvent {}

class SaveWifiSsidEvent extends GeofenceEvent {
  final String wifiSsid;
  SaveWifiSsidEvent({this.wifiSsid});
}

class SaveCircleEvent extends GeofenceEvent {
  final String xPoint, yPoint, radius;

  SaveCircleEvent({
    this.xPoint,
    this.yPoint,
    this.radius,
  });
}

class IsInsideEvent extends GeofenceEvent {}

class GoToConfigEvent extends GeofenceEvent {}
