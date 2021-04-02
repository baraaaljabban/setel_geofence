import 'package:flutter/material.dart';
import 'package:setel_geofanc/core/Strings/cash_strings.dart';
import 'package:setel_geofanc/error/exceptions.dart';
import 'package:setel_geofanc/features/geofence/data/model/circle_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

/// [GeofenceLocalDataSource] [abstract class] it will coraborate with [GeofenceLocalDataSourceImpl] [class]
/// to save and restore data from locale database
abstract class GeofenceLocalDataSource {
  /// save `wifi name (SSID)` in local database
  void saveWifiSsid({@required String wifiName});

  /// restore `Wifi Name` from the local database
  String getSavedWifiSsid();
  CircleModel getCircleConfig();
  //save Circle Config
  void saveCircleConfig({
    @required double xPoint,
    @required double yPoint,
    @required double radius,
  });
}

/// [GeofenceLocalDataSourceImpl] [class] is to save and restore data from
/// locale database like `wifi SSID` and if not found will throw `Cache Excepition`
/// `extends` from `GeofenceLocalDataSource` for more abstruction
class GeofenceLocalDataSourceImpl extends GeofenceLocalDataSource {
  final SharedPreferences sharedPreferences;

  GeofenceLocalDataSourceImpl({this.sharedPreferences});
  @override
  String getSavedWifiSsid() {
    String cachedWifi = sharedPreferences.getString(CASHED_WIFI);
    developer.log("the wifi in LocalDB is : $cachedWifi");
    if (cachedWifi == null || cachedWifi.isEmpty)
      throw CacheException(message: "WIFI_ERROR : please save Wifi first");
    else
      return cachedWifi;
  }

  @override
  void saveWifiSsid({String wifiName}) {
    developer.log("the wifi name will be saved like : $wifiName");
    sharedPreferences.setString(CASHED_WIFI, wifiName);
  }

  @override
  void saveCircleConfig({double xPoint, double yPoint, double radius}) {
    developer.log(
        "Circle Config saved like :\n xPoint $xPoint \n yPoint $yPoint\n radius $radius");
    sharedPreferences.setDouble(CIRCLE_X_POINT, xPoint);
    sharedPreferences.setDouble(CIRCLE_Y_POINT, yPoint);
    sharedPreferences.setDouble(CIRCLE_RADIUS, radius);
  }

  @override
  CircleModel getCircleConfig() {
    CircleModel circleModel = CircleModel(
        xPoint: sharedPreferences.getDouble(CIRCLE_X_POINT),
        yPoint: sharedPreferences.getDouble(CIRCLE_Y_POINT),
        radius: sharedPreferences.getDouble(CIRCLE_RADIUS));
    if (circleModel.radius == null || circleModel.radius == 0)
      throw CacheException(message: "radius (null or 0) please save circle config first!");
    else if (circleModel.xPoint == null || circleModel.xPoint == 0)
      throw CacheException(message: "xPoint (null or 0) please save circle config first!");
    else if (circleModel.yPoint == null || circleModel.yPoint == 0)
      throw CacheException(message: "yPoint (null or 0) please save circle config first!");
    else
      return circleModel;
  }
}
