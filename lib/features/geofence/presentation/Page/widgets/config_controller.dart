import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofanc/features/geofence/presentation/bloc/geofence_bloc.dart';

class ConfigController extends StatefulWidget {
  ConfigController({Key key}) : super(key: key);

  @override
  _ConfigControllerState createState() => _ConfigControllerState();
}

class _ConfigControllerState extends State<ConfigController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Configrations!"),
        actions: [],
      ),
      body: Container(
        child: null,
      ),
    );
  }
  // onPressed: () {
  //   _saveWifiEvent();
  // },

  // void _saveWifiEvent() {
  //   BlocProvider.of<GeofenceBloc>(context).add(SaveWifiSsidEvent());
  // }
}
