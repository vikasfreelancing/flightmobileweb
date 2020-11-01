import 'package:flightmobileweb/model/aiprorts.dart';

class FlightStopTicket {
  String id;
  int fromAirportId;
  int toAirportId;
  String fromAirport;
  String toAirport;
  String flightNumber;
  bool showDetails = false;
  DateTime departureDate;
  DateTime arrivalDate;
  double price;
  bool freeLeg;
  int seats;
  FlightStopTicket(this.fromAirport, this.toAirport, this.price,
      this.flightNumber, this.departureDate, this.arrivalDate);
  Map<String, dynamic> toJson() => {
    'fromAirport': fromAirport,
    'toAirport': toAirport,
    'flightNumber': flightNumber,
    'departureDate': departureDate,
    'arrivalDate': arrivalDate,
    'price':price,
    'freeLeg':freeLeg,
    'id':id
  };
  FlightStopTicket.fromJson(Map<String, dynamic> json)
      : fromAirportId = json['startairportid'],
        toAirportId = json['endairportid'],
        flightNumber = json['aircraftid'],
        departureDate = DateTime.parse(json['starttime']),
        arrivalDate = DateTime.parse(json['endtime']),
        //price = double.parse(json['price']),
        freeLeg=json['freeleg'],
        id=json['id'],
        fromAirport= AirportModel.getAirportNameFromId(json['startairportid']),
        toAirport= AirportModel.getAirportNameFromId(json['endairportid'])
  ;
}
class FlightFilter{
  int fromCity;
  int toCity;
  DateTime date;
  int seats;
}
