import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:setel_geofanc/core/Strings/export_strings.dart';
import 'package:setel_geofanc/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'dart:developer' as developer;
import 'package:permission_handler/permission_handler.dart';

/// first will check
///
///*[if] we have `Permission`
///then will see if it's IOS or android and try to get the wifi name
///if we got the wifi name null of empty
///
///*[else] will try to get `Permission` either the user in that case give us
///the Permission but turnd off the location service so will try to request for the permission
/// or user did not give us Permission so we well open the App setting for him/here
/// to give us the access to location services
Future<Either<Failure, String>> saveCurrentWifiSsid(
    {@required WifiInfo wifiInfo}) async {
  String wifiName = "";
  if (await Permission.location.isGranted) {
    // Use location.
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled)
      try {
        if (!kIsWeb && Platform.isIOS) {
          LocationAuthorizationStatus status =
              await wifiInfo.getLocationServiceAuthorization();
          if (status == LocationAuthorizationStatus.notDetermined) {
            status = await wifiInfo.requestLocationServiceAuthorization();
          }
          if (status == LocationAuthorizationStatus.authorizedAlways ||
              status == LocationAuthorizationStatus.authorizedWhenInUse) {
            wifiName = await wifiInfo.getWifiName();
          } else {
            wifiName = await wifiInfo.getWifiName();
          }
        } else {
          wifiName = await wifiInfo.getWifiName();
        }
        if (wifiName != null || wifiName.isNotEmpty)
          return Right(WE_SAVED_YOUR_WIFI + "$wifiName");
        else
          return Left(UnknownFailuer(message: COULD_NOT_GET_WITI_NAME));
      } on PlatformException catch (e) {
        developer.log(e.toString());
        return Left(UnknownFailuer(message: COULD_NOT_GET_WITI_NAME));
      } catch (e) {
        developer.log(e.toString());
        return Left(UnknownFailuer(message: COULD_NOT_GET_WITI_NAME));
      }
    else {
      final r = await Permission.location.request();
      if (r.isDenied) openAppSettings();
      return Left(UnknownFailuer(message: ENABLE_LOCATION));
    }
  } else {
    final r = await Permission.location.request();
    if (r.isDenied)
      return Left(UnknownFailuer(message: GIVE_PERMISSION));
    else
      return Right("got access");
  }
}

class InputConverter {
  ///check whether the values enterd by user are double accepted thene return it
  ///
  ///`value1 = xPoint`
  ///
  ///`value2 = yPoint`
  ///
  ///`value3 = radius`
  Either<Failure, Tuple3<double, double, double>> stringToUnsignedDouble({
    String xPoint,
    String yPoint,
    String radius,
  }) {
    try {
      final x = double.parse(xPoint);
      final y = double.parse(yPoint);
      final r = double.parse(radius);
      if (x < 0)
        throw FormatException("x format worng");
      else if (y < 0)
        throw FormatException("y format worng");
      else if (r < 0) throw FormatException("radius format worng");

      return Right(Tuple3(x, y, r));
    } on FormatException catch (e) {
      return Left(InvalidInputFailure(e.message));
    }
  }
}
