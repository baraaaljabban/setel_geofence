import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

/// NetworkInfo to check wither you are connected
/// and you have access to Internt
/// [isconnected] check accessabilty by pinging
/// [hassconnectivity] are you cnnected to wifi or celler netowrk
abstract class NetworkInfo {
  Future<bool> get isconnected;
  Future<bool> get hassconnectivity;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;
  final Connectivity connectivity;
  NetworkInfoImpl({this.dataConnectionChecker, this.connectivity});

  /// check if I have access to internet
  @override
  Future<bool> get isconnected => dataConnectionChecker.hasConnection;

  /// check wither Device is [connected] to mobile or [wifi]
  @override
  Future<bool> get hassconnectivity async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)
      return true;
    else
      return false;
  }
}
