import 'package:flightmobileweb/search/search_flight.dart';
import 'package:flightmobileweb/components/sideMenu.dart';
import 'package:flightmobileweb/components/flight_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context,constraints){
          if(constraints.maxWidth < 600)
            return buildSearchPageSmall(context);
          else
            return buildSearchPageSLarge(context);
        },
      ),
    );
  }
  Widget buildSearchPageSmall(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      body: LayoutBuilder(
        builder: (context,constraints){
          return
            Stack(
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
            );
        },
      ),
    );
  }
  Widget buildSearchPageSLarge(BuildContext context){
  return Scaffold(
    drawer: NavDrawer(),
    body: LayoutBuilder(
      builder: (context,constraints){
        return
          Stack(
            children: <Widget>[
              Flight(height: 1000,screen: 'Search',),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 70.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(flex:3,child: NavDrawer(),),
                      Expanded(flex:7,child: SearchFlight()),
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

