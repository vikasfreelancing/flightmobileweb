//https://524daec2-5808-4ef3-846c-72d491febd8a.mock.pstmn.io/cities
import 'package:flightmobileweb/model/flight_user.dart';

class City {
  static List<City> myCities;
  static Map<int,String> idToNameMap;
  static Map<String,int> nameToIdMap;
  static List<City> getCities(){
    print('Getting City storage ${FlightUser.storage.getItem('cities')}');
    if(myCities == null && FlightUser.storage.getItem('cities')!=null)
      myCities = (FlightUser.storage.getItem('cities')as List)
          .map((i) => City.fromJson(i))
          .toList();
    return myCities;
  }
  static void setCities(List<City> city){
    myCities = city;
    FlightUser.storage.setItem('cities', myCities);
    //print('Setting storage ${FlightUser.storage.getItem('cities')}');
  }

  static int getCityIdFromName(String name){
    return myCities.firstWhere((element) => element.name==name).cityId;
  }
  static String getCityNameFromId(int cityId){
    return myCities.firstWhere((element) => element.cityId==cityId).name;
  }
  int cityId;
  String code;
  String name;
  Map<String, dynamic> toJson() => {
    'cityid': cityId,
    'code': code,
    'name': name,
  };
  City.fromJson(Map<String, dynamic> json)
      : cityId =json['cityid'],
        code = json['code'],
        name = json['name']
  ;
}
