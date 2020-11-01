import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class BookFlightWidget extends StatefulWidget {
  final FlightFilter flightFilter;
  BookFlightWidget({this.flightFilter});
  @override
  BookFlightWidgetState createState() {
    return new BookFlightWidgetState();
  }
}

class BookFlightWidgetState extends State<BookFlightWidget>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;

  @override
  void initState() {
    super.initState();
    textInputAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    textInputAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
