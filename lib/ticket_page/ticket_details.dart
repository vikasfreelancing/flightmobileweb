import 'package:flightmobileweb/book/booking_page.dart';
import 'package:flightmobileweb/login/pages/login_page.dart';
import 'package:flightmobileweb/model/flight_user.dart';
import 'package:flightmobileweb/ticket_page/flyer_details_page.dart';
import 'package:flutter/material.dart';
import '../model/flight_stop_ticket.dart';

class BookTicketButton extends StatefulWidget {
  final FlightStopTicket stop;
  BookTicketButton({Key key, this.stop}) : super(key: key);
  @override
  _BookTicketButtonState createState() => _BookTicketButtonState();
}

class _BookTicketButtonState extends State<BookTicketButton> {
  FlightStopTicket stopTicket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stopTicket = widget.stop;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//              RaisedButton(
//                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => PaymentPage()));
//                },
//                child: Image.asset(
//                  "assets/img/book.png",
//                  height: 20,
//                  width: 100,
//                ),
//              )
              RaisedButton(
                onPressed: () {
                  if(FlightUser.getCurrentUser()==null)
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  else
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BookingPage(flightStopTicket: stopTicket,)));
                },
                color: Colors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Book Now",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
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
            ],
          ),
        ),
      ),
    );
  }
}
