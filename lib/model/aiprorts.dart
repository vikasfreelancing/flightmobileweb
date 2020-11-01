import 'package:flightmobileweb/model/flight_user.dart';

class AirportModel {
  /*     "actualcityid": 1,
        "airportid": 1385,
        "code": "AAF",
        "countryid": 1,
        "description": "Apalachicola Regional",
        "name": "Apalachicola Regional"
  * */
  int actualcityid;
  int airportid;
  String code;
  int countryid;
  String description;
  String name;
  static List<AirportModel> airPorts;

  static List<AirportModel> getAirports() {
    //print('Getting airport storage ${FlightUser.storage.getItem('airport')}');
    if(airPorts == null && FlightUser.storage.getItem('airport')!=null)
      airPorts = (FlightUser.storage.getItem('airport')as List)
          .map((i) => AirportModel.fromJson(i))
          .toList();
    return airPorts;
  }

  static void setAirports(List<AirportModel> airport) {
    airPorts = airport;
    FlightUser.storage.setItem('airport', airPorts);
   // print('Setting Airport storage ${FlightUser.storage.getItem('airport')}');

  }


  static int getAirportIdFromName(String name){
    AirportModel airportModel = airPorts.firstWhere((element) => element.name==name);
    if(airportModel==null)
      return 0;
    else
      return airportModel.airportid;
  }
  static String getAirportNameFromId(int airportId){
    AirportModel airportModel =airPorts.firstWhere((element) => element.airportid==airportId);
    if(airportModel == null)
      return "UnknownAirport";
    else
      return airportModel.name;
  }

  Map<String, dynamic> toJson() => {
        'actualcityid': actualcityid,
        'code': code,
        'name': name,
        'airportid': airportid,
        'countryid': countryid,
        'description': description,
      };

  AirportModel.fromJson(Map<String, dynamic> json)
      : actualcityid = json['actualcityid'],
        code = json['code'],
        name = json['name'],
        airportid = json['airportid'],
        countryid = json['countryid'],
        description = json['description'];
}
