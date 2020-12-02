import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flightmobileweb/commons/commons.dart';
import 'package:flightmobileweb/flightService/flight_ticket_service.dart';
import 'package:flightmobileweb/model/SaleFlightModel.dart';
import 'package:flightmobileweb/model/aiprorts.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
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
                  Row(
                    children: [
                      Expanded(
                        flex:2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: Icon(Icons.flight_takeoff,color: Colors.blue,),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
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
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: Icon(Icons.flight_land,color: Colors.blue,),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: buildDropDownToAirport(),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                            child: Icon(Icons.person,color: Colors.blue,),
                          )
                      ),
                      Expanded(flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
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
                            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                            child: Icon(Icons.attach_money,color: Colors.blue,),
                          )
                      ),
                      Expanded(flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
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
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: Icon(Icons.date_range, color: Colors.blue),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
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
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: Icon(Icons.date_range, color: Colors.blue),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
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
    return SearchableDropdown.single(
      validator: (value)=>(value==null)?'Please select from airport':null,
      items: items,
      onChanged: (fromAirport){
         print(fromAirport);
         int id = AirportModel.getAirportIdFromName(fromAirport);
         widget.saleFlightTicket.fromAirport = id;
         widget.saleFlightTicket.fromAirportName = fromAirport;
      },
      value: 0,
      hint: "Select From Airport",
      searchHint: "Select from Airport",
      doneButton: "Done",
      displayItem: (item, selected) {
        return (Row(children: [
          selected
              ? Icon(
            Icons.radio_button_checked,
            color: Colors.grey,
          )
              : Icon(
            Icons.radio_button_unchecked,
            color: Colors.grey,
          ),
          SizedBox(width: 7),
          Expanded(
            child: item,
          ),
        ]));
      },
      isExpanded: true,
    );
  }

  Widget buildDropDownToAirport() {
    return SearchableDropdown.single(
      validator: (value)=>(value==null)?'Please select to Airport':null,
      items: items,
      onChanged: (toAirport){
        int id = AirportModel.getAirportIdFromName(toAirport);
        widget.saleFlightTicket.toAirport = id;
        widget.saleFlightTicket.toAirportName = toAirport;
      },
      value: 0,
      hint: "Select To Airport",
      searchHint: "Select To Airport",
      doneButton: "Done",
      displayItem: (item, selected) {
        return (Row(children: [
          selected
              ? Icon(
            Icons.radio_button_checked,
            color: Colors.grey,
          )
              : Icon(
            Icons.radio_button_unchecked,
            color: Colors.grey,
          ),
          SizedBox(width: 7),
          Expanded(
            child: item,
          ),
        ]));
      },
      isExpanded: true,
    );
  }


  CurvedAnimation _buildInputAnimation({double begin, double end}) {
    return new CurvedAnimation(
        parent: textInputAnimationController,
        curve: Interval(begin, end, curve: Curves.linear));
  }
  Widget basicDateField(BuildContext context) {
    final format = DateUtil.format;
    return DateTimeField(
      validator:(value)=>widget.saleFlightTicket.departureDate==null?'Please select a date':null,
      format: format,
      decoration: InputDecoration(
        labelText: "Departure",
      ),
      onChanged: (date) {
        print(date);
       widget.saleFlightTicket.departureDate = date;
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
  Widget basicDateFieldArrival(BuildContext context) {
    final format = DateUtil.format;
    return DateTimeField(
      validator:(value)=>widget.saleFlightTicket.reachingTime==null?'Please select a date':null,
      format: format,
      decoration: InputDecoration(
        labelText: "Arrival",
      ),
      onChanged: (date) {
        print(date);
        widget.saleFlightTicket.reachingTime = date;
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
