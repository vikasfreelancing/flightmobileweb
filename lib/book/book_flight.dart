import 'package:flightmobileweb/book/book_flight_input.dart';
import 'package:flightmobileweb/commons/commons.dart';
import 'package:flightmobileweb/components/button.dart';
import 'package:flightmobileweb/details/confirmation_page.dart';
import 'package:flightmobileweb/flightService/flight_ticket_service.dart';
import 'package:flightmobileweb/flightService/user_service.dart';
import 'package:flightmobileweb/login/widgets/loader_hud.dart';
import 'package:flightmobileweb/model/BookingModel.dart';
import 'package:flightmobileweb/model/TravelHistory.dart';
import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flightmobileweb/model/flight_user.dart';
import 'package:flightmobileweb/search/search_flight_input.dart';
import 'package:flightmobileweb/ticket_page/tickets_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class BookFlight extends StatefulWidget {
  BookFlight({this.flightStopTicket});

  final FlightStopTicket flightStopTicket;

  @override
  _BookFlightState createState() => _BookFlightState();
}

class _BookFlightState extends State<BookFlight> {
  int picked = 0;
  bool valueFirst = false;
  bool loading = false;
  List<TravelHistory> travelHistoryList;
  List<BookingModel> bookings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(travelHistoryList==null)fetchTravelHistory();
  }

  void fetchTravelHistory() async {
    setState(() {
      loading = true;
    });
    this.travelHistoryList = await UserService().getTravellingHistory();
    setState(() {
      loading = false;
    });
  }

  bool addForm = false;

  @override
  Widget build(BuildContext context) {
    return LoaderHUD(
      inAsyncCall: loading,
      child: WillPopScope(
        onWillPop: () {
          return Future(() => true);
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
          child: new IntrinsicHeight(child: _buildBookingWidget()),
        ),
      ),
    );
  }

  Widget _buildBookingWidget() {
    List<Widget> list = List();
    if (travelHistoryList == null)
      list.add(Center(
       child:Padding(
         padding: const EdgeInsets.all(16.0),
         child: Text((loading)?"Loading travel history":"No travel history found"
             ,style: TextUtil.textStyle,
         ),
       )
      ));
    else
    travelHistoryList.forEach((element) {
      list.add(_buildCheckbox(element));
    });
    list.add((addForm) ? newPassengerForm(context) : addMoreButton(context));
    list.add(nextButton(context));
    return Column(
      children: list,
    );
  }

  //next button
  Widget nextButton(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RaisedButton(
          disabledColor: Colors.grey,
          onPressed:(widget.flightStopTicket.seats !=picked)?null:() {
            setState(() {
              loading = true;
            });
            bookings = List<BookingModel>();
            travelHistoryList.forEach((history) {
              if(history.selected){
                if(history.mobile==null){
                  history.mobile = FlightUser.getCurrentUser().phoneNumber;
                }
                bookings.add(BookingModel(flightId: widget.flightStopTicket.flightNumber
                    ,age: history.age,name: history.name,userId: history.userId,mobile: history.mobile
                ));
              }
            });
            loading = false;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConfirmationPage(bookings: bookings,stopTicket: widget.flightStopTicket,)));

          },
          color: Colors.blue[900],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: (widget.flightStopTicket.seats == picked)?Colors.blue[900]:Colors.grey,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Add more button to add other then got in history

  Widget addMoreButton(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RaisedButton(
          onPressed: () {
            setState(() {
              addForm = true;
            });
          },
          color: Colors.blue,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add More',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//Check box view

  Widget _buildCheckbox(TravelHistory travelHistory) {
    final nameStyle = TextStyle(
        fontFamily: 'WorkSans-Italic-VariableFont_wght',
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.blue[900],
        letterSpacing: 2);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 8,
              child: Text("${travelHistory.name} ,", style: nameStyle)),
          Expanded(
            flex: 4,
            child: Text(
              "${travelHistory.age}",
              style: TextStyle(
                  fontFamily: 'WorkSans-Italic-VariableFont_wght',
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                  color: Colors.blue,
                  letterSpacing: 2),
            ),
          ),
          Expanded(
            flex: 4,
            child: Checkbox(
              value: travelHistory.selected,
              activeColor: Colors.green,
              onChanged: (value) {
                //print(value);
                if (value) picked++;
                if (!value) picked--;
                if (picked == widget.flightStopTicket.seats + 1) {
                  picked--;
                  return;
                }
                setState(() {
                  travelHistory.selected = !travelHistory.selected;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  //Add new passenger form

  Widget newPassengerForm(BuildContext context) {
    TravelHistory travelHistory = TravelHistory();
    travelHistory.selected = false;
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TextFormField(
                onChanged: (name) {
                  travelHistory.name = name;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.person_add, color: Colors.blue),
                  labelText: "Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TextFormField(
                onChanged: (age) {
                  travelHistory.age = int.parse(age);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.confirmation_number, color: Colors.blue),
                  labelText: "age",
                ),
              ),
            ),
            Row(
              children: [
                collepseButton(context),
                formAddPassengerButton(context, travelHistory)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget collepseButton(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RaisedButton(
          onPressed: () {
            setState(() {
              addForm = false;
            });
          },
          color: Colors.blue,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Return',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formAddPassengerButton(
      BuildContext context, TravelHistory travelHistory) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RaisedButton(
          onPressed: () {
            setState(() {
              travelHistoryList.add(travelHistory);
              addForm = false;
            });
          },
          color: Colors.blue,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
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
