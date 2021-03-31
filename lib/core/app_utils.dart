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
  if (await Permission.location.isGranted &&
      await Permission.locationWhenInUse.serviceStatus.isEnabled) {
    // Use location.
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
  } else {
    openAppSettings();
    final r = await Permission.location.request();
    if (r.isDenied)
      return Left(UnknownFailuer(message: GIVE_PERMISSION));
    else
      return Right("got access");
  }
}
