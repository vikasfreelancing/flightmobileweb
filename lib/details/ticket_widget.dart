import 'package:flightmobileweb/commons/commons.dart';
import 'package:flightmobileweb/model/BookingModel.dart';
import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:intl/intl.dart';
class FlightTicketWidget extends StatefulWidget {
  FlightTicketWidget({this.stopTicket,this.booking});
  final FlightStopTicket stopTicket;
  final BookingModel booking;
  @override
  _FlightTicketWidgetState createState() => _FlightTicketWidgetState();
}

class _FlightTicketWidgetState extends State<FlightTicketWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FlutterTicketWidget(
          color: Colors.blue[50],
          width: 500.0,
          height: 200.0,
          isCornerRounded: true,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '${widget.stopTicket.fromAirport}',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.flight_takeoff,
                            color: Colors.pink,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '${widget.stopTicket.toAirport}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    children: <Widget>[
                      ticketDetailsWidget(
                          'Passengers', '${widget.booking.name}', 'Date', '${DateUtil.format.format(widget.stopTicket.departureDate)}'),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, right: 40.0),
                        child: ticketDetailsWidget(
                            'Mobile', '${widget.booking.mobile}', 'Age', '${widget.booking.age}'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}