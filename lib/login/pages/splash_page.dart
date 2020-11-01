import 'package:flightmobileweb/flightService/user_service.dart';
import 'package:flightmobileweb/model/flight_user.dart';
import 'package:flightmobileweb/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flightmobileweb/search/search_page.dart';
import 'package:flightmobileweb/login/pages/login_page.dart';
import 'package:flightmobileweb/login/stores/login_store.dart';
import 'package:flightmobileweb/components/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Provider
        .of<LoginStore>(context, listen: false)
        .isAlreadyAuthenticated()
        .then((result) {
      if (result != null) {
        if (result.isRegistered) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => SearchPage()),
                  (Route<dynamic> route) => false);
        }
        else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => RegisterPage()),
                  (Route<dynamic> route) => false);
        }
      }
      else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
                (Route<dynamic> route) => false);
      }
    }
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: MyColors.primaryColor,
  );
}}
