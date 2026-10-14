import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/favourite/favourite_status_service.dart';
import 'package:shopping_app/core/common/screens/under_maintenance_screen.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/auth_bootstrap.dart';
import 'package:shopping_app/core/storage_helper/shared_pref.dart';
import 'package:shopping_app/core/utils/app_bloc_observer.dart';
import 'package:shopping_app/shopping_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) =>
      UnderMaintenanceScreen();
  await SharedPref.init();
  await AuthBootstrap.ensureToken();

  await configureDependencies();
  await serviceLocator<FavouriteStatusService>().initialize();
  Bloc.observer = AppBlocObserver();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(const ShoppingApp()));
}
