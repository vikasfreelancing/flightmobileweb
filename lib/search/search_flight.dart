import 'package:flightmobileweb/flightService/flight_ticket_service.dart';
import 'package:flightmobileweb/login/widgets/loader_hud.dart';
import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flightmobileweb/search/search_flight_input.dart';
import 'package:flightmobileweb/ticket_page/tickets_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SearchFlight extends StatefulWidget {
  @override
  _SearchFlightState createState() => _SearchFlightState();
}

class _SearchFlightState extends State<SearchFlight> {
  final _formKey = GlobalKey<FormState>();
  bool loading=false;
  List<FlightStopTicket> tickets = List();
  bool showFlights = false;
  FlightFilter flightFilter = FlightFilter();

  @override
  Widget build(BuildContext context) {
    return LoaderHUD(
      inAsyncCall: loading,
      child: WillPopScope(
        onWillPop: () {
          if (showFlights) {
            setState(() {
              showFlights = false;
            });
            return Future(() => false);
          } else {
            return Future(() => true);
          }
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
          child: new IntrinsicHeight(child: _buildBookFlight()),
        ),
      ),
    );
  }

  Widget _buildBookFlight() {
    return Column(
      children: <Widget>[
        SearchFlightInput(flightFilter: flightFilter,formKey: _formKey,),
        FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () async {
              if(!_formKey.currentState.validate())
                return false;
              setState(() {
                loading = true;
              });
              List<FlightStopTicket> response = await FlightTicketService().getFlightsTickets(
                  flightFilter.date, flightFilter.fromCity,
                  flightFilter.toCity, flightFilter.seats);
              setState(() {
                showFlights = true;
                tickets = response;
                loading = false;
                //TODO: call flight service & fetch flight details
              });
            },
            child: Icon(
              Icons.search,
              size: 36,
              //color: Colors.blue,
            )),
        if (showFlights) TicketsPage(tickets:tickets,),
      ],
    );
  }
}
