part of 'geofence_bloc.dart';

@immutable
abstract class GeofenceEvent {}

class SaveWifiSsidEvent extends GeofenceEvent {}

class IsInsideEvent extends GeofenceEvent {}
