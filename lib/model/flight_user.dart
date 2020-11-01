import 'package:flightmobileweb/commons/commons.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert' as decoder;
class FlightUser {
  static FlightUser user;
  static final LocalStorage storage = new LocalStorage('flight');
  static void setUser(FlightUser flightUser){
    print("storage ${storage.getItem('flight_user')}");
    print("User $flightUser");
    if(flightUser==null) return;
    print("Saving user ${flightUser.toJsonStorage()}");
    user = flightUser;
    storage.setItem('flight_user', flightUser.toJsonStorage());
  }
  static FlightUser getCurrentUser(){
    print("storage ${storage.getItem('flight_user')}");
    if(user==null && storage.getItem('flight_user')!=null){
        user=FlightUser.fromJsonStorage(storage.getItem('flight_user'));
    }
    return user;
  }
  FlightUser();
  String phoneNumber;
  String dob;
  String password;
  String displayName;
  int userType;
  bool isVerified;
  String userToken;
  int userId;
  String country;
  bool isRegistered;
  String genderCode;
  Map<String, dynamic> toJson() => {
    'username': phoneNumber,
    //'birthdate': dob,
    'displayname': displayName,
    'usertype': 1,
    //'userToken': userToken,
    //'isVerified':isVerified,
    //'userid':userId,
    'isregistrationcomplete':isRegistered,
    'gendercode':'M'
    //'country':country
  };
  Map<String, dynamic> toJsonStorage() => {
    'username': phoneNumber,
    'birthdate': dob,
    'displayname': displayName,
    'usertype': 1,
    'userToken': userToken,
    'isVerified':isVerified,
    'userid':userId,
    'password':password,
    'isregistrationcomplete':isRegistered,
    'gendercode':genderCode
  };
  FlightUser.fromJson(Map<String, dynamic> json)
      : phoneNumber = json['username'],
        //dob = json['birthdate'],
        displayName = json['displayname'],
        userType = json['usertype'],
        isVerified = json['isverified'],
        userId = json['userid'],
        isRegistered = json['isregistrationcomplete'],
        genderCode = json['gendercode']
  ;

  FlightUser.fromJsonStorage(Map<String, dynamic> json)
      : phoneNumber = json['username'],
        dob = (json['birthdate']==null)?null:json['birthdate'],
        displayName = json['displayname'],
        userType = json['usertype'],
        isVerified = json['isverified'],
        userId = json['userid'],
        isRegistered = json['isregistrationcomplete'],
        genderCode = json['gendercode'],
        userToken = json['userToken']
  ;

  static Future<void> logout(){
    storage.deleteItem('flight_user');
  }
}
