import 'package:flightmobileweb/components/sideMenu.dart';
import 'package:flightmobileweb/components/flight_bar.dart';
import 'package:flightmobileweb/sale/sale_flight.dart';
import 'package:flutter/material.dart';
import 'package:flightmobileweb/commons/commons.dart' as com;
class SalePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:com.decoration,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context,constraints){
            if(constraints.maxWidth < 600)
              return buildSalePageSmall(context);
            else
              return Center(child: SizedBox(width: 900,child: buildSalePageLarge(context)));
          },
        ),
      ),
    );
  }


  Widget buildSalePageSmall(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      body: LayoutBuilder(
        builder: (context,constraints){
          return
            Stack(
              children: <Widget>[
                Flight(height: 1000,screen: 'Sale',),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 70.0),
                    child: new Column(
                      children: <Widget>[
                        Expanded(child: SaleFlight()),
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
  Widget buildSalePageLarge(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      body: LayoutBuilder(
        builder: (context,constraints){
          return
            Stack(
              children: <Widget>[
                Flight(height: 1000,screen: 'Sale',),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 220.0),
                    child: new Row(
                      children: <Widget>[
                        Expanded(flex:3,child: NavDrawerLarge(),),
                        Expanded(flex:7,child: SaleFlight()),
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
