import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofanc/features/geofence/presentation/Page/widgets/config_controller.dart';

import 'core/injection_service.dart';
import 'features/geofence/presentation/Page/geofence_page.dart';
import 'features/geofence/presentation/bloc/geofence_bloc.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GeofenceBloc>(
          create: (BuildContext context) => sl<GeofenceBloc>(),
          child: GeofenceBlocPage(),
        ),
        //TODO: either spreate pages and blocs || change Navigation way
        BlocProvider<GeofenceBloc>(
          create: (BuildContext context) => sl<GeofenceBloc>(),
          child: ConfigController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (builtContext) {
          return GeofenceBlocPage();
        }),
      ),
    );
  }
}
