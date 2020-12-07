import 'package:flightmobileweb/commons/commons.dart';
import 'package:flightmobileweb/commons/dateFileld.dart';
import 'package:flightmobileweb/flightService/flight_ticket_service.dart';
import 'package:flightmobileweb/model/SaleFlightModel.dart';
import 'package:flightmobileweb/model/aiprorts.dart';
import 'package:flutter/material.dart';
import 'package:flightmobileweb/commons/dropdown.dart';
class SaleFlightInput extends StatefulWidget {
  final formKey ;
  final SaleFlightTicketModel saleFlightTicket;
  SaleFlightInput({this.formKey,this.saleFlightTicket});
  @override
  SaleFlightInputState createState() {
    return new SaleFlightInputState();
  }
}

class SaleFlightInputState extends State<SaleFlightInput>
    with TickerProviderStateMixin {
  bool loadingAirports=true;
  AnimationController textInputAnimationController;
  List<DropdownMenuItem> items = List();
  bool asTabs = false;
  void loadAirports() async{
    List<AirportModel> airports = await FlightTicketService().getAirports();
    setState(() {
      airports.forEach((airport) {
        items.add(DropdownMenuItem(
          value: airport.name,
          child: Text("${airport.name}"),
        ));
      });
      AirportModel.setAirports(airports);
      loadingAirports = false;
    });

  }

  List<DropdownMenuItem> createCityDropDown(List<AirportModel> airports){
    List<DropdownMenuItem> tempitems = List();
    airports.forEach((airport) {
      tempitems.add(DropdownMenuItem(
        value: airport.name,
        child: Text("${airport.name}"),
      ));
    });
    return tempitems;
  }
  @override
  void initState() {
    super.initState();
    textInputAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    if(AirportModel.getAirports() == null)
      loadAirports();
    else
      setState(() {
        items = createCityDropDown(AirportModel.getAirports());
        loadingAirports =false;
      });
  }

  @override
  void dispose() {
    textInputAnimationController.dispose();
    super.dispose();
  }
  final Widget progressIndicator = Container(
    width: 200,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      color: Colors.blue.withOpacity(0.7),
    ),
    child: const Center(child: CircularProgressIndicator()),
  );
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: [
          Form(
            key:widget.formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text("Sale your Flight",style: TextUtil.textStyleHeading,),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex:2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                          child: Icon(Icons.flight_takeoff,color: Colors.blue,),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                          child: buildDropDownFromAirport(),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex:2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                          child: Icon(Icons.flight_land,color: Colors.blue,),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                          child: buildDropDownToAirport(),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                            child: Icon(Icons.person,color: Colors.blue,),
                          )
                      ),
                      Expanded(flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator:(seats)=>widget.saleFlightTicket.seats==null?'Please add number of seats available ':null,
                            onChanged: (seats){
                              widget.saleFlightTicket.seats = int.parse(seats);
                            },
                            decoration: InputDecoration(
                              labelText: "seats",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                            child: Icon(Icons.attach_money,color: Colors.blue,),
                          )
                      ),
                      Expanded(flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator:(seats)=>widget.saleFlightTicket.priceperseat==null?'Please provide price/seat ':null,
                            onChanged: (seats){
                              widget.saleFlightTicket.priceperseat = double.parse(seats);
                            },
                            decoration: InputDecoration(
                              labelText: "price/seat",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                          child: Icon(Icons.date_range, color: Colors.blue),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                          child: basicDateField(context),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                          child: Icon(Icons.date_range, color: Colors.blue),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                          child: basicDateFieldArrival(context),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          if(loadingAirports) Center(child: progressIndicator)]
    );
  }

  Widget buildDropDownFromAirport() {
    return DropDown(items, 'Select from Airport', 'Please select a Airport',(value){
      print(value);
      int id = AirportModel.getAirportIdFromName(value);
      widget.saleFlightTicket.fromAirport = id;
    });
  }

  Widget buildDropDownToAirport() {
    return DropDown(items, 'Select to Airport', 'Please select a Airport',(value){
      print(value);
      int id = AirportModel.getAirportIdFromName(value);
      widget.saleFlightTicket.toAirport = id;
    });
  }
  Widget basicDateField(BuildContext context) {
    return FlightDate('Departure', 'Please select a date', (value){
      widget.saleFlightTicket.departureDate = value;
    });
  }
  Widget basicDateFieldArrival(BuildContext context) {
    return FlightDate('Arrival', 'Please select a date', (value){
      widget.saleFlightTicket.reachingTime = value;
    });
  }
}
