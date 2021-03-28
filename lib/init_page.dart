import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel/features/restaurant/presentation/bloc/restaurant_bloc.dart';

import 'core/injection_service.dart';
import 'features/restaurant/presentation/page/restaurant_page.dart';

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
        BlocProvider<RestaurantBloc>(
          create: (BuildContext context) => sl<RestaurantBloc>(),
          child: RestaurantPage(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (builtContext) {
          return RestaurantPage();
        }),
      ),
    );
  }
}
