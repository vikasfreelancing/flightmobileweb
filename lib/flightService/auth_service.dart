import 'dart:convert' as decoder;

import 'package:flightmobileweb/model/auth_model.dart';
import 'package:flightmobileweb/model/send_otp_request.dart';
import 'package:flightmobileweb/model/flight_user.dart';
import 'package:http/http.dart' as http;
class AuthService {
  static Future<FlightUser> verifyOtp(AuthCredentials authCredentials) async {
    String endPoint = "";
    print("endpoint : " + endPoint);
    print("mobile : ${authCredentials.phone} code: ${authCredentials.smsCode}");
    http.Response response = await http.post(
        "https://flight-qu755gur4a-uc.a.run.app/v1/users/verifyuser",
        headers: {"Content-Type": "application/json"},
        body: decoder.jsonEncode({
          "username":authCredentials.phone,
          "password":authCredentials.smsCode
        })
    );
    print("Response code: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("Response : " + response.body);
      String token = decoder.json.decode(response.body)['jwt_token'];
      FlightUser user = FlightUser();
      user.phoneNumber = authCredentials.phone;
      user.password = authCredentials.smsCode;
      user.userToken = token;
      FlightUser.setUser(user);
      return user;
    }
    else
      throw Exception("Not able to verify");
  }

  static Future<String> sendOtp(SendOtpRequest request) async {
    String endPoint = "https://flight-qu755gur4a-uc.a.run.app/v1/opt/otpbyusername/" +
        request.mobile;
    print("endpoint : " + endPoint);
    http.Response response = await http.get(
      endPoint,
      headers: {"Content-Type": "application/json"},
    );
    print("Response code: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("Response : " + response.body);
      return "SUCCESS";
    }
    else throw Exception("Can't send otp");
  }
}