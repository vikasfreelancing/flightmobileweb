import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flightmobileweb/commons/commons.dart';
import 'package:flightmobileweb/login/widgets/loader_hud.dart';
import 'package:flightmobileweb/model/flight_user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterInput extends StatefulWidget {
  final FlightUser flightUser;
  final formKey;
  RegisterInput({this.flightUser,this.formKey});
  @override
  RegisterInputState createState() {
    return new RegisterInputState();
  }
}

class RegisterInputState extends State<RegisterInput>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;
  bool loading=false;
  FlightUser flightUser;
  @override
  void initState() {
    super.initState();
    flightUser = widget.flightUser;
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
    return LoaderHUD(
      inAsyncCall: loading,
      child: Container(
        child: Form(
          key: widget.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                  child: TextFormField(
                    validator: (value)=>(flightUser.displayName==null)?"Please enter display name":null,
                    //animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                    onChanged: (displayName) {
                      flightUser.displayName = displayName;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.blue),
                      labelText: "Display Name",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                  child: basicDateField(context),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.accessibility, color: Colors.blue),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: DropdownButtonFormField(
                          hint: Text("Select gender"),
                          validator: (value)=>(flightUser.genderCode==null)?'Please select gender':null,
                          onChanged: (value){
                            flightUser.genderCode = value;
                          },
                          items: [DropdownMenuItem(
                            value: "M",
                            child: Text("Male"),
                          ),DropdownMenuItem(
                            value: "F",
                            child: Text("Female"),
                          )],
                        ),
                      ),
                    ),
                  ],

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // CurvedAnimation _buildInputAnimation({double begin, double end}) {
  //   return new CurvedAnimation(
  //       parent: textInputAnimationController,
  //       curve: Interval(begin, end, curve: Curves.linear));
  // }

  Widget basicDateField(BuildContext context) {
    final format = DateUtil.format;
    return DateTimeField(
      format: format,
      validator: (value)=>(flightUser.dob==null)?"Please enter date of birth":null,
      decoration: InputDecoration(
        icon: Icon(Icons.date_range, color: Colors.blue),
        labelText: "DOB",
      ),
      onChanged: (dob) {
        flightUser.dob = DateUtil.format.format(dob);
      },
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    );
  }
}
