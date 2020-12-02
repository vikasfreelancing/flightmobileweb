import 'package:flightmobileweb/model/TravelHistory.dart';
import 'package:flightmobileweb/model/flight_user.dart';
import 'dart:convert' as decoder;
import 'flight_constants.dart';
import 'package:http/http.dart' as http;
class UserService{
  Future<FlightUser> getUser() async {
    final user = FlightUser.getCurrentUser();
    String token = user.userToken;
    String password = user.password;
    String endPoint = flightServiceBaseUrl+getUserApi;
    print("endpoint : " + endPoint);
    http.Response response = await http.get(
      endPoint,
      headers: {"Content-Type": "application/json","api-token":user.userToken},
    );
    print("Response code: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("Response : " + response.body);
      FlightUser user = FlightUser.fromJson(decoder.json.decode(response.body));
      user.userToken = token;
      user.password = password;
      FlightUser.setUser(user);
      return user;
    }
    else{
      return null;
    }
  }
  Future<List<TravelHistory>> getTravellingHistory() async {
    print("Calling get Travel History Service");
    final user = FlightUser.getCurrentUser();
    String url = flightServiceBaseUrl+getTravelHistory;
    url="https://flight-qu755gur4a-uc.a.run.app/v1/users/persons/me";
    http.Response response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "api-token": user.userToken
    });
    print(response.body);
    if (response.statusCode == 200 && response.body != null) {
      print("Response Travel history: " + response.body);
      List<TravelHistory> items =
      (decoder.json.decode(response.body) as List)
          .map((i) => TravelHistory.fromJson(i))
          .toList();
      return items;
    } else
      return null;
  }


  Future<FlightUser> saveUser(FlightUser user) async {
    final user = FlightUser.getCurrentUser();
    String endPoint = flightServiceBaseUrl+saveUserApi;
    endPoint = "https://flight-qu755gur4a-uc.a.run.app/v1/users/me";
    print("endpoint : " + endPoint);
    http.Response response = await http.put(
      endPoint,
      headers: {"Content-Type": "application/json","api-token":user.userToken},
      body: decoder.jsonEncode(user.toJson())
    );
    print("Response code: " + response.body.toString());
    if (response.statusCode == 200) {
      print("Response : " + response.body);
      FlightUser user = FlightUser.fromJson(decoder.json.decode(response.body));
      FlightUser savedUser = FlightUser.getCurrentUser();
      user.userToken = savedUser.userToken;
      user.phoneNumber=savedUser.phoneNumber;
      user.password=savedUser.password;
      FlightUser.setUser(user);
      return user;
    }
    else{
      return null;
    }
  }
  
}