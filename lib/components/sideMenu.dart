import 'package:flightmobileweb/model/flight_user.dart';
import 'package:flightmobileweb/sale/SalePage.dart';
import 'package:flightmobileweb/login/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flightmobileweb/search/search_page.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer();
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  FlightUser flightUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flightUser= FlightUser.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[50]),
            child: Center(
              child: Text(
                "${(flightUser!=null)?"Hello "+flightUser.displayName:"Login"}",
                style: TextStyle(color: Colors.black, fontSize: 25,fontFamily: "WorkSans-Italic-VariableFont_wght"
                ,fontWeight: FontWeight.bold),
              ),
            ),
           ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.inbox),
            title: Text('Book'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Sale'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SalePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              LoginStore loginStore = LoginStore();
              loginStore.signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
