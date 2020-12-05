import 'package:flightmobileweb/book/booking_page.dart';
import 'package:flightmobileweb/flightService/auth_service.dart';
import 'package:flightmobileweb/flightService/user_service.dart';
import 'package:flightmobileweb/login/pages/constants.dart';
import 'package:flightmobileweb/login/pages/login_page.dart';
import 'package:flightmobileweb/login/pages/otp_page.dart';
import 'package:flightmobileweb/model/auth_model.dart';
import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flightmobileweb/model/send_otp_request.dart';
import 'package:flightmobileweb/model/flight_user.dart';
import 'package:flightmobileweb/register/register_page.dart';
import 'package:flightmobileweb/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  String actualCode;
  @observable
  bool isLoginLoading = false;
  @observable
  bool isOtpLoading = false;

  @observable
  GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  @observable
  GlobalKey<ScaffoldState> otpScaffoldKey = GlobalKey<ScaffoldState>();
  @observable
  FlightUser user;

  @action
  Future<FlightUser> isAlreadyAuthenticated() async {
    user = FlightUser.getCurrentUser();
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  @action
  Future<void> getCodeWithPhoneNumber(
      BuildContext context, String phoneNumber) async {
    isLoginLoading = true;
    SendOtpRequest sendOtpRequest = SendOtpRequest();
    sendOtpRequest.mobile = phoneNumber;
    await AuthService.sendOtp(sendOtpRequest).catchError((error) {
      print(error);
      isLoginLoading = false;
      loginScaffoldKey.currentState.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(
          'Can not send otp try after some time',
          style: TextStyle(color: Colors.white),
        ),
      ));
    }).then((value) => {
          if (value != null)
            {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => OtpPage(
                        mobile: phoneNumber,
                      )))
            }
        });
  }

  @action
  Future<void> validateOtpAndLogin(
      BuildContext context, String smsCode, String mobile) async {
    isOtpLoading = true;
    final AuthCredentials _authCredential =
        AuthCredentials(smsCode: smsCode, phone: mobile);

    await AuthService.verifyOtp(_authCredential).catchError((error) {
      isOtpLoading = false;
      otpScaffoldKey.currentState.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(
          'Wrong code ! Please enter the last code received.',
          style: TextStyle(color: Colors.white),
        ),
      ));
    }).then((value) => {
          if (value != null && value.userToken != null)
            {
              print("Sucessfull login"),
              onAuthenticationSuccessful(context, value)
            }
        });
  }

//onAuthenticationSuccessful(context, authResult);
  Future<void> onAuthenticationSuccessful(
      BuildContext context, FlightUser newUser) async {
    isLoginLoading = true;
    isOtpLoading = true;
    print("User $newUser");
    FlightUser user = newUser;
    FlightUser.setUser(user);
    user = await UserService().getUser();
    FlightUser.setUser(user);
    if (!user.isRegistered)
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => RegisterPage()),
          (Route<dynamic> route) => false);
    else{
      if(FlightStopTicket.getSavedTicket()!=null){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => BookingPage(flightStopTicket: FlightStopTicket.getSavedTicket(),)),
                (Route<dynamic> route) => false);
      }
      else
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => SearchPage()),
              (Route<dynamic> route) => false);
    }
    isLoginLoading = false;
    isOtpLoading = false;
  }

  @action
  Future<void> signOut(BuildContext context) async {
    await FlightUser.logout();
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginPage()),
        (Route<dynamic> route) => false);
    FlightUser.setUser(null);
  }
}
