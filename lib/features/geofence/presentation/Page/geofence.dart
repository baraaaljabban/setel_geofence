import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofanc/features/common/common_widgets.dart';
import 'package:setel_geofanc/features/geofence/domain/usecases/geofence_uc.dart';
import 'package:setel_geofanc/features/geofence/presentation/Page/widgets/config_controller.dart';
import 'package:setel_geofanc/features/geofence/presentation/bloc/geofence_bloc.dart';

class GeofenceBlocPage extends StatefulWidget {
  GeofenceBlocPage({Key key}) : super(key: key);

  @override
  _GeofenceBlocPageState createState() => _GeofenceBlocPageState();
}

class _GeofenceBlocPageState extends State<GeofenceBlocPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
        body: BlocConsumer<GeofenceBloc, GeofenceState>(
          listener: (context, state) {
            if (state is Loading)
              CommonWidgets.showLoadingSnackBar(context);
            else if (state is Error)
              CommonWidgets.showErrorSnackBar(
                context,
                message: state.message,
              );
            else if (state is SuccessSaveWifiState)
              CommonWidgets.showSuccessSnackBar(context,
                  message: state.message);
          },
          builder: (context, state) {
            if (state is GoToConfigControllerState)
              return ConfigController();
            else
              return Container();
          },
        ),
      ),
    );
  }

  void _goToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfigController()),
    );

    // BlocProvider.of<GeofenceBloc>(context).add(GoToConfigEvent());
  }
}
