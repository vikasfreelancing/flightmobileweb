import 'dart:convert' as decoder;
import 'package:flightmobileweb/commons/commons.dart';
import 'package:flightmobileweb/flightService/user_service.dart';
import 'package:flightmobileweb/model/SaleFlightModel.dart';
import 'package:flightmobileweb/model/aiprorts.dart';
import 'package:flightmobileweb/model/city.dart';
import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flightmobileweb/model/flight_user.dart';
import 'package:http/http.dart' as http;
import 'flight_constants.dart';

class FlightTicketService {
  Future<List<FlightStopTicket>> getFlightsTickets(
      DateTime departureDate, int fromCity, int toCity, int passengers) async {
    print(
        "Calling getFlight Service for fromCity:$fromCity toCity: $toCity number of passengers: $passengers ,Departure date $departureDate");
    final user = FlightUser.getCurrentUser();
    Map<String, dynamic> requestBody = {
      'journeydate': DateUtil.format.format(departureDate),
      'startcityid': fromCity,
      'endcityid': toCity,
      'numberofseats': passengers
    };
    String url = flightServiceBaseUrl + searchFlightTickets;
    print(decoder.jsonEncode(requestBody));
    //url="https://d2d48070-9afe-4fc9-9f05-2532c4e48366.mock.pstmn.io/mock3";
    http.Response response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "api-token": user.userToken,
        },
        body: decoder.jsonEncode(requestBody));
    List<AirportModel> airports = AirportModel.getAirports();
    if(airports == null) airports = await FlightTicketService().getAirports();
    if (response.statusCode == 200 && response.body != null) {
      print("Response get Flights : " + response.body);
      List<FlightStopTicket> items =
          (decoder.json.decode(response.body) as List)
              .map((i) => FlightStopTicket.fromJson(i))
              .toList();
      items.forEach((element) {
        element.seats = passengers;
      });
      return items;
    } else
      return null;
  }

  Future<List<City>> getCities() async {
    print("Calling getCities Service");
    final user = FlightUser.getCurrentUser();
    String url = flightServiceBaseUrl + getCitesMasterData;
    url = "https://524daec2-5808-4ef3-846c-72d491febd8a.mock.pstmn.io/cities";
    http.Response response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "token": user.userToken,
    });
    if (response.statusCode == 200 && response.body != null) {
      print("Response get Lost Items : " + response.body);
      List<City> items = (decoder.json.decode(response.body) as List)
          .map((i) => City.fromJson(i))
          .toList();
      return items;
    } else
      return null;
  }

  Future<List<AirportModel>> getAirports() async {
    print("Calling get Airports Service");
    final user = FlightUser.getCurrentUser();
    String url = flightServiceBaseUrl + getAirportsMasterData;
    url = "https://aad31b78-224e-4849-aec8-8e1b10d0520a.mock.pstmn.io/airports";
    http.Response response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "api-token": user.userToken
    });
    if (response.statusCode == 200 && response.body != null) {
      print("Response get Lost Items : " + response.body);
      List<AirportModel> items = (decoder.json.decode(response.body) as List)
          .map((i) => AirportModel.fromJson(i))
          .toList();
      AirportModel.setAirports(items);
      return items;
    } else
      return null;
  }

  Future<String> saleFlightTickets(SaleFlightTicketModel ticket) async {
    final user = FlightUser.getCurrentUser();
    ticket.userId = user.userId;
    String endPoint = flightServiceBaseUrl +
        saleFlightTicketsUrl; //"https://d226828f-675e-40e2-b2aa-6b94c8faf396.mock.pstmn.io/sale";
    print("endpoint : " + endPoint);
    print(decoder.jsonEncode(ticket.toJson()));
    http.Response response = await http.post(endPoint,
        headers: {
          "Content-Type": "application/json",
          "api-token": user.userToken
        },
        body: decoder.jsonEncode(ticket.toJson()));
    print("Response code: " + response.statusCode.toString());
    print("${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Response : " + response.body);
      // SaleFlightTicketModel ticket = SaleFlightTicketModel.fromJson(decoder.json.decode(response.body));
      // return ticket;
      return "SUCESS";
    } else {
      throw Exception("Not able to save flights");
    }
  }

  Future<List<SaleFlightTicketModel>> saleFlightTicketsHistory() async {
    final user = FlightUser.getCurrentUser();
    String endPoint = flightServiceBaseUrl + saleFlightHistoryUrl;
    print("endpoint : " + endPoint);
    http.Response response = await http.get(endPoint,
        headers: {
          "Content-Type": "application/json",
          "api-token": user.userToken
        },
    );
    print("Response code: " + response.statusCode.toString());
    print("${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Response : " + response.body);
      List<SaleFlightTicketModel> history =
      (decoder.json.decode(response.body) as List)
          .map((i) => SaleFlightTicketModel.fromJson(i))
          .toList();
      List<AirportModel> airports = AirportModel.getAirports();
      if(airports == null)
        airports = await getAirports();
      history.forEach((element) {
        element.fromAirportName = AirportModel.getAirportNameFromId(element.fromAirport);
        element.toAirportName = AirportModel.getAirportNameFromId(element.toAirport);
      });
      return history;
    } else {
      throw Exception("Not able to save flights");
    }
  }




}
