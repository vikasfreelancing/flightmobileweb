import 'package:flightmobileweb/flightService/user_service.dart';
import 'package:flightmobileweb/model/flight_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flightmobileweb/login/pages/splash_page.dart';
import 'package:flightmobileweb/login/stores/login_store.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
void main() async {
  if (!kIsWeb && Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await FlightUser.storage.ready;
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    //initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginStore>(
          create: (_) => LoginStore(),
        ),
        Provider<FlightUser>(
          create: (_)=>FlightUser.getCurrentUser(),
        )
      ],
      child: MaterialApp(
        home: SplashPage(),
      ),
    );
  }
}
