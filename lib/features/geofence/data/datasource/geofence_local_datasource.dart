import 'package:flutter/material.dart';
import 'package:setel_geofanc/core/Strings/cash_strings.dart';
import 'package:setel_geofanc/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

/// [GeofenceLocalDataSource] [abstract class] it will coraborate with [GeofenceLocalDataSourceImpl] [class]
/// to save and restore data from locale database
abstract class GeofenceLocalDataSource {
  /// save `wifi name (SSID)` in local database
  void saveWifiSsid({@required String wifiName});

  /// restore `Wifi Name` from the local database
  String getSavedWifiSsid();
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
      throw CacheException();
    else
      return cachedWifi;
  }

  @override
  void saveWifiSsid({String wifiName}) {
    developer.log("the wifi name will be saved like : $wifiName");
    sharedPreferences.setString(CASHED_WIFI, wifiName);
  }
}
