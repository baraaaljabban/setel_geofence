part of 'geofence_bloc.dart';

@immutable
abstract class GeofenceState {}

class GeofenceInitial extends GeofenceState {}

class SuccessSaveWifiState extends GeofenceState {
  final String message;
  SuccessSaveWifiState({this.message});
}

class Error extends GeofenceState {
  final String message;
  Error({this.message});
}

class IsInsideState extends GeofenceState {
  final bool isInisde;
  IsInsideState({this.isInisde});
}

class IsOutInsideState extends GeofenceState {}

class Loading extends GeofenceState {}

class GoToConfigControllerState extends GeofenceState {}
