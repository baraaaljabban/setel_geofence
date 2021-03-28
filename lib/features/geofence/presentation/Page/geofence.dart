import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofanc/features/common/common_widgets.dart';
import 'package:setel_geofanc/features/geofence/domain/usecases/geofence_uc.dart';
import 'package:setel_geofanc/features/geofence/presentation/bloc/geofence_bloc.dart';

class GeofenceBlocPage extends StatefulWidget {
  GeofenceBlocPage({Key key}) : super(key: key);

  @override
  _GeofenceBlocPageState createState() => _GeofenceBlocPageState();
}

class _GeofenceBlocPageState extends State<GeofenceBlocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<GeofenceBloc, GeofenceState>(
        listener: (context, state) {
          if (state is Loading)
            CommonWidgets.showLoadingSnackBar(context);
          else if (state is Error)
            CommonWidgets.showErrorSnackBar(
              context,
              message: state.message,
            );
          else if (state is SuccessSaveWifiState)
            CommonWidgets.showSuccessSnackBar(context, message: state.message);
        },
        child: Container(
          child: Center(
              child: MaterialButton(
            child: Text("GF"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            onPressed: () {
              _saveWifiEvent();
            },
          )),
        ),
      ),
    );
  }

  void _saveWifiEvent() async {
    BlocProvider.of<GeofenceBloc>(context).add(SaveWifiSsidEvent());
  }
}
