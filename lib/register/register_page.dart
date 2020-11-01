import 'package:flightmobileweb/components/flight_bar.dart';
import 'package:flightmobileweb/register/register.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Flight(height: 1000,screen: 'Register',),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 70.0),
              child: new Column(
                children: <Widget>[
                  Expanded(child: Register()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
