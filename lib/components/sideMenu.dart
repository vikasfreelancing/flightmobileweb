import 'package:flightmobileweb/login/pages/login_page.dart';
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            ListTile(
              //decoration: BoxDecoration(color: Colors.blue[50],shape: BoxShape.rectangle,),
              title: Text(
              "${(flightUser!=null)?"Welcome "+flightUser.displayName:"Please login"}",
              style: TextStyle(color: Colors.black, fontSize: 25,fontFamily: "WorkSans-Italic-VariableFont_wght"
              ,fontWeight: FontWeight.bold),
              ),
             ),
            if(FlightUser.getCurrentUser()!=null)ListTile(
              leading: Icon(Icons.input),
              title: Text('Welcome'),
              onTap: () {},
            ),
            if(FlightUser.getCurrentUser()!=null)ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () {},
            ),
            if(FlightUser.getCurrentUser()!=null)ListTile(
              leading: Icon(Icons.inbox),
              title: Text('Book'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
            if(FlightUser.getCurrentUser()!=null)ListTile(
              leading: Icon(Icons.message),
              title: Text('Sale'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SalePage()));
              },
            ),
            if(FlightUser.getCurrentUser()!=null)ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                LoginStore loginStore = LoginStore();
                loginStore.signOut(context);
              },
            ),
            if(FlightUser.getCurrentUser()==null)ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Login'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NavDrawerLarge extends StatefulWidget {
  @override
  _NavDrawerLargeState createState() => _NavDrawerLargeState();
}

class _NavDrawerLargeState extends State<NavDrawerLarge> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Our vision for your comfort",
                    style: TextStyle(color: Colors.black, fontSize: 25,fontFamily: "WorkSans-Italic-VariableFont_wght"
                        ,fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                    style: TextStyle(color: Colors.black, fontSize: 15,fontFamily: "WorkSans-Italic-VariableFont_wght"
                        ,fontWeight: FontWeight.normal),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Our vision for your comfort",
                    style: TextStyle(color: Colors.black, fontSize: 25,fontFamily: "WorkSans-Italic-VariableFont_wght"
                        ,fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                    style: TextStyle(color: Colors.black, fontSize: 15,fontFamily: "WorkSans-Italic-VariableFont_wght"
                        ,fontWeight: FontWeight.normal),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Our vision for your comfort",
                    style: TextStyle(color: Colors.black, fontSize: 25,fontFamily: "WorkSans-Italic-VariableFont_wght"
                        ,fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                    style: TextStyle(color: Colors.black, fontSize: 15,fontFamily: "WorkSans-Italic-VariableFont_wght"
                        ,fontWeight: FontWeight.normal),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavDrawerTop extends StatefulWidget {
  @override
  _NavDrawerTopState createState() => _NavDrawerTopState();
}

class _NavDrawerTopState extends State<NavDrawerTop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          if(FlightUser.getCurrentUser()!=null)ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () {},
          ),
          if(FlightUser.getCurrentUser()!=null)ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () {},
          ),
          if(FlightUser.getCurrentUser()!=null)ListTile(
            leading: Icon(Icons.inbox),
            title: Text('Book'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
          if(FlightUser.getCurrentUser()!=null)ListTile(
            leading: Icon(Icons.message),
            title: Text('Sale'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SalePage()));
            },
          ),
          if(FlightUser.getCurrentUser()!=null)ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              LoginStore loginStore = LoginStore();
              loginStore.signOut(context);
            },
          ),
          if(FlightUser.getCurrentUser()==null)ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Login'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
      ),
    );
  }
}


