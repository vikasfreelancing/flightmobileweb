import 'package:flightmobileweb/book/book_flight.dart';
import 'package:flightmobileweb/model/TravelHistory.dart';
import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flightmobileweb/search/search_flight.dart';
import 'package:flightmobileweb/components/sideMenu.dart';
import 'package:flightmobileweb/components/flight_bar.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  BookingPage({this.flightStopTicket});
  final FlightStopTicket flightStopTicket;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context,constraints){
          if(constraints.maxWidth < 600)
            return buildBookingPageSmall(context);
          else
            return buildBookingPageLarge(context);
        },
      ),
    );
  }


  Widget buildBookingPageSmall(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      body: LayoutBuilder(
        builder: (context,constraints){
          return
            Stack(
              children: <Widget>[
                Flight(height: 1000,screen: 'Book',),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 70.0),
                    child: new Column(
                      children: <Widget>[
                        Expanded(child: BookFlight(flightStopTicket: flightStopTicket,)),
                      ],
                    ),
                  ),
                ),
              ],
            );
        },
      ),
    );
  }
  Widget buildBookingPageLarge(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      body: LayoutBuilder(
        builder: (context,constraints){
          return
            Stack(
              children: <Widget>[
                Flight(height: 1000,screen: 'Book',),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 70.0),
                    child: new Row(
                      children: <Widget>[
                        Expanded(flex:3,child: NavDrawer(),),
                        Expanded(flex:7,child: BookFlight(flightStopTicket: flightStopTicket,)),
                      ],
                    ),
                  ),
                ),
              ],
            );
        },
      ),
    );
  }
}
