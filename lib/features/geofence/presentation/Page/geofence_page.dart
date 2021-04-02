import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofanc/core/Strings/export_strings.dart';
import 'package:setel_geofanc/core/injection_service.dart';
import 'package:setel_geofanc/features/common/common_widgets.dart';
import 'package:setel_geofanc/features/geofence/presentation/Page/widgets/config_controller.dart';
import 'package:setel_geofanc/features/geofence/presentation/bloc/geofence_bloc.dart';

class GeofenceBlocPage extends StatefulWidget {
  GeofenceBlocPage({Key key}) : super(key: key);

  @override
  _GeofenceBlocPageState createState() => _GeofenceBlocPageState();
}

class _GeofenceBlocPageState extends State<GeofenceBlocPage> {
  TextEditingController circleYPointController = TextEditingController();
  TextEditingController circleXPointController = TextEditingController();
  final CommonWidgets commonWidgets = sl<CommonWidgets>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Geofence area!"),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
              ),
              onPressed: () {
                _goToSettings();
              },
            )
          ],
        ),
        body: BlocListener<GeofenceBloc, GeofenceState>(
          listener: (context, state) {
            if (state is Error)
              commonWidgets.showErrorSnackBar(
                context,
                message: state.message,
              );
          },
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enter a value (X,Y)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: circleXPointController,
                  style: TextStyle(color: Colors.white),
                  decoration: commonWidgets.inputDecorations("X 0.0"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: circleYPointController,
                  style: TextStyle(color: Colors.white),
                  decoration: commonWidgets.inputDecorations("Y 0.0"),
                  keyboardType: TextInputType.number,
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
                    _isInisdeTriger();
                  },
                  child: Text(
                    'Check',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.055,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BlocBuilder<GeofenceBloc, GeofenceState>(
                  builder: (context, state) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            (state is IsInsideState)
                                ? "$GEOFENCE/in.png"
                                : (state is IsOutInsideState
                                    ? "$GEOFENCE/out.png"
                                    : "$GEOFENCE/init.png"),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _isInisdeTriger() {
    BlocProvider.of<GeofenceBloc>(context).add(
      IsInsideEvent(
        xPoint: circleXPointController.text,
        yPoint: circleYPointController.text,
      ),
    );
    circleXPointController.clear();
    circleYPointController.clear();
  }

  @override
  void dispose() {
    circleYPointController.dispose();
    circleXPointController.dispose();
    super.dispose();
  }

  void _goToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfigController()),
    );

  }
}
