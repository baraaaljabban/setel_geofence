import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofanc/features/common/common_widgets.dart';
import 'package:setel_geofanc/features/geofence/domain/usecases/save_circle_uc.dart';
import 'package:setel_geofanc/features/geofence/presentation/bloc/geofence_bloc.dart';

class ConfigController extends StatefulWidget {
  ConfigController({Key key}) : super(key: key);

  @override
  _ConfigControllerState createState() => _ConfigControllerState();
}

class _ConfigControllerState extends State<ConfigController> {
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
      body: BlocListener<GeofenceBloc, GeofenceState>(
        listener: (context, state) {
          if (state is Error)
            CommonWidgets.showErrorSnackBar(
              context,
              message: state.message,
            );
          else if (state is SuccessSaveWifiState)
            CommonWidgets.showSuccessSnackBar(context, message: state.message);
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
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
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Circle Info",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: circleXPointController,
                    style: TextStyle(color: Colors.white),
                    decoration: inputDecorations("X"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: circleYPointController,
                    style: TextStyle(color: Colors.white),
                    decoration: inputDecorations("Y"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: circleRadiusController,
                    style: TextStyle(color: Colors.white),
                    decoration: inputDecorations("Radius"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.orange;
                      },
                    ),
                  ),
                  onPressed: () {
                    _saveCircleEvent();
                  },
                  child: Text('Save Circle Info'),
                ),
                Spacer(flex: 1),
                Divider(
                  height: 1,
                  endIndent: MediaQuery.of(context).size.width * 0.12,
                  indent: MediaQuery.of(context).size.width * 0.12,
                  color: Colors.white,
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Wifi Info",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: wifiSsidController,
                  style: TextStyle(color: Colors.white),
                  decoration:
                      inputDecorations("WIFI Name.. you can leave blank"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.orange;
                      },
                    ),
                  ),
                  onPressed: () {
                    _saveWifiEvent();
                  },
                  child: Text('Save Wifi'),
                ),
                Spacer(flex: 2)
              ],
            ),
          ),
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
    BlocProvider.of<GeofenceBloc>(context).add(
      SaveCircleEvent(
        xPoint: circleXPointController.text,
        yPoint: circleYPointController.text,
        radius: circleRadiusController.text,
      ),
    );
  }

  void _saveWifiEvent() {
    BlocProvider.of<GeofenceBloc>(context).add(SaveWifiSsidEvent(
      wifiSsid: wifiSsidController.text,
    ));
  }

  InputDecoration inputDecorations(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white),
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
  }
}
