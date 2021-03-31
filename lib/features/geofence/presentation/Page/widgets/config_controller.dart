import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofanc/features/geofence/presentation/bloc/geofence_bloc.dart';

class ConfigController extends StatefulWidget {
  ConfigController({Key key}) : super(key: key);

  @override
  _ConfigControllerState createState() => _ConfigControllerState();
}

class _ConfigControllerState extends State<ConfigController> {
  InputDecoration inputDecoration = InputDecoration(
    hintText: "wifiName",
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white)),
    contentPadding: EdgeInsets.all(8.0),
  );
  TextEditingController circleYPointController = TextEditingController();
  TextEditingController circleXPointController = TextEditingController();
  TextEditingController circleRadiusController = TextEditingController();
  TextEditingController wifiSsidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Configrations!"),
        actions: [],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.grey[900],
            Colors.blueGrey[900],
            Colors.blueGrey[800],
            Colors.blueGrey[700],
            Colors.blueGrey[600],
            Colors.blueGrey,
            Colors.blueGrey[300],
          ],
        )),
        child: Column(
          children: [
            Text(
              "Circle Info",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: circleXPointController,
              style: TextStyle(color: Colors.white),
              decoration: inputDecoration,
            ),
            TextField(
              controller: circleYPointController,
              style: TextStyle(color: Colors.white),
              decoration: inputDecoration,
            ),
            TextField(
              controller: circleRadiusController,
              style: TextStyle(color: Colors.white),
              decoration: inputDecoration,
            ),
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.orange;
                    },
                  ),
                ),
                onPressed: () {},
                child: Text('Save Circle Info'),
              ),
            ),
            Expanded(
              child: Divider(
                height: 1,
                endIndent: MediaQuery.of(context).size.width * 0.12,
                indent: MediaQuery.of(context).size.width * 0.12,
                color: Colors.white,
              ),
            ),
            Text(
              "Wifi Info",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: wifiSsidController,
              style: TextStyle(color: Colors.white),
              decoration: inputDecoration,
            ),
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.orange;
                    },
                  ),
                ),
                onPressed: () {},
                child: Text('Save Wifi'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    circleYPointController.dispose();
    circleXPointController.dispose();
    circleRadiusController.dispose();
    wifiSsidController.dispose();
    super.dispose();
  }

  void _saveCircleEvent() {
    BlocProvider.of<GeofenceBloc>(context).add(SaveCircleEvent());
  }

  void _saveWifiEvent() {
    BlocProvider.of<GeofenceBloc>(context).add(SaveWifiSsidEvent());
  }
}
