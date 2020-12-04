import 'package:flightmobileweb/components/sideMenu.dart';
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
          alignment: Alignment.topCenter,
          child: Image.asset('assets/img/m1.jpeg'),
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.white],
            ),
          ),
          height: height,
        ),
        new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Container(
            alignment: Alignment.topLeft,
              child: Text("Flight",textAlign:TextAlign.left,)),
          ),
      ],
    );
  }
}
// new Text(
// "Flight $screen",
// style: TextStyle(
// fontFamily: 'WorkSans-Italic-VariableFont_wght',
// fontWeight: FontWeight.bold,
// fontSize: 25,
// letterSpacing: 4),
// )