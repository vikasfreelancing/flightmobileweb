import 'package:flightmobileweb/flightService/user_service.dart';
import 'package:flightmobileweb/login/widgets/loader_hud.dart';
import 'package:flightmobileweb/model/flight_user.dart';
import 'package:flightmobileweb/register/register_input.dart';
import 'package:flightmobileweb/register/register_page.dart';
import 'package:flightmobileweb/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  FlightUser flightUser;
  bool showFlights = false;
  bool loading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flightUser = FlightUser.getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return LoaderHUD(
      inAsyncCall: loading,
      child: WillPopScope(
        onWillPop: () {
            return Future(() => false);
        },
        child: new Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(8.0),
          child: DefaultTabController(
            child: new LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return Column(
                  children: <Widget>[
                    _buildContentContainer(viewportConstraints),
                  ],
                );
              },
            ),
            length: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildContentContainer(BoxConstraints viewportConstraints) {
    return Expanded(
      child: SingleChildScrollView(
        child: new ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: viewportConstraints.maxHeight - 48.0,
          ),
          child: new IntrinsicHeight(child: _buildMulticityTab()),
        ),
      ),
    );
  }

  Widget _buildMulticityTab() {
    return Column(
      children: <Widget>[
        RegisterInput(flightUser: flightUser,formKey: _formKey,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () async {
                if(!_formKey.currentState.validate()){
                  return ;
                }
                setState(() {
                  loading = true;
                });
                flightUser.isRegistered = true;
                FlightUser savedUser =
                await UserService().saveUser(flightUser);
                setState(() {
                  loading = false;
                });
                if (savedUser == null) {
                  //TODO if not able to save then redirect to register page with error message
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => RegisterPage()));
                } else {
                  //TODO: if success then redirect to bookpage and save flight user in cache globally
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage()));
                }
              },
              child: Icon(
                Icons.save,
                size: 36,
                //color: Colors.blue,
              )),
        )
        ]);
  }
}
