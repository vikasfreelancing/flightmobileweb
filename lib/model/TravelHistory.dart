class TravelHistory{
  TravelHistory();
  String userId;
  String name;
  int age;
  String mobile;
  int id;
  bool selected=false;


  Map<String, dynamic> toJson() => {
    'userId': userId,
    'age': age,
    'name': name,
    'mobile': mobile,
    'id':id
  };
  TravelHistory.fromJson(Map<String, dynamic> json)
      : userId = json['userid'].toString(),
        age = 10,
        name = json['name'],
        mobile = '1234',
        id=int.parse('123')
  ;
}