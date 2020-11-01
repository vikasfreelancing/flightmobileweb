import 'package:flutter/material.dart';

class Flight extends StatelessWidget {
  final double height;
  final String screen;
  const Flight({Key key, this.height,this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, const Color(0xCAEA4AAA)],
            ),
          ),
          height: height,
        ),
        new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: new Text(
            "Flight $screen",
            style: TextStyle(
                fontFamily: 'WorkSans-Italic-VariableFont_wght',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 4),
          ),
        ),
      ],
    );
  }
}
