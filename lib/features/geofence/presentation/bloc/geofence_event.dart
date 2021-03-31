part of 'geofence_bloc.dart';

@immutable
abstract class GeofenceEvent {}

class SaveWifiSsidEvent extends GeofenceEvent {}

class SaveCircleEvent extends GeofenceEvent {}

class IsInsideEvent extends GeofenceEvent {}

class GoToConfigEvent extends GeofenceEvent {}
