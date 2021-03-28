import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofanc/core/injection_service.dart' as di;
import 'core/simple_bloc_delegate.dart';
import 'init_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = SimpleBlocDelegate();
  runApp(App());
}
