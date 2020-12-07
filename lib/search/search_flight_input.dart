import 'package:flightmobileweb/commons/commons.dart';
import 'package:flightmobileweb/commons/dateFileld.dart';
import 'package:flightmobileweb/commons/dropdown.dart';
import 'package:flightmobileweb/flightService/flight_ticket_service.dart';
import 'package:flightmobileweb/model/city.dart';
import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flutter/material.dart';
class SearchFlightInput extends StatefulWidget {
  final formKey ;
  final FlightFilter flightFilter;
  SearchFlightInput({this.flightFilter,this.formKey});
  @override
  SearchFlightInputState createState() {
    return new SearchFlightInputState();
  }
}

class SearchFlightInputState extends State<SearchFlightInput>
    with TickerProviderStateMixin {
  bool loadingCities=true;
  AnimationController textInputAnimationController;
  List<DropdownMenuItem> items = [];
  bool asTabs = false;
  List<DropdownMenuItem> createCityDropDown(List<City> cities){
    List<DropdownMenuItem> tempitems = List();
    cities.forEach((city) {
     // print(city.cityId);
      tempitems.add(DropdownMenuItem(
        value: city.name,
        child: Text("${city.name}"),
      ));
    });
    return tempitems;
  }
  void loadCities() async{
     List<City> cites = await FlightTicketService().getCities();
     setState(() {
       cites.forEach((city) {
         items.add(DropdownMenuItem(
           value: city.name,
           child: Text("${city.name}"),
         ));
       });
       City.setCities(cites);
       loadingCities = false;
     });

  }
  @override
  void initState() {
    super.initState();
    textInputAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    if(City.getCities() == null)
    loadCities();
    else
      setState(() {
        items = createCityDropDown(City.getCities());
        loadingCities =false;
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
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12),
                child: Text("Search your Flight",style: TextUtil.textStyleHeading,),
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
                      child: buildDropDownFromCity(),
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
                      child: buildDropDownToCity(),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                        child: Icon(Icons.people,color: Colors.blue,),
                      )
                  ),
                  Expanded(flex: 15,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator:(seats)=>widget.flightFilter.seats==null?'Please provide number of seats ':null,
                        onChanged: (seats){
                          widget.flightFilter.seats = int.parse(seats);
                        },
                        decoration: InputDecoration(
                          labelText: "seat",
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
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                      child: basicDateField(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      if(loadingCities) Center(child: progressIndicator)]
    );
  }

  Widget buildDropDownFromCity() {
    return DropDown(items, 'Select from City', 'Please select a city',(value){
        print(value);
        int id = City.getCityIdFromName(value);
        widget.flightFilter.fromCity = id;
    });
  }
  Widget buildDropDownToCity() {
    return DropDown(items, 'Select to City', 'Please select a city',(value){
      print(value);
      int id = City.getCityIdFromName(value);
      widget.flightFilter.toCity = id;
    });
  }
  Widget basicDateField(BuildContext context) {
    return FlightDate('Flying Date', 'Please select a date', (value){
      widget.flightFilter.date = value;
    });
  }
}
