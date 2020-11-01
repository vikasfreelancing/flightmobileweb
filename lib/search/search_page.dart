import 'package:flightmobileweb/search/search_flight.dart';
import 'package:flightmobileweb/components/sideMenu.dart';
import 'package:flightmobileweb/components/flight_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: Stack(
        children: <Widget>[
          Flight(height: 1000,screen: 'Search',),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 70.0),
              child: new Column(
                children: <Widget>[
                  Expanded(child: SearchFlight()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
