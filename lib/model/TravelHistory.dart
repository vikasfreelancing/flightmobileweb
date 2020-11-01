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
      : userId = json['userId'],
        age = int.parse(json['age']),
        name = json['name'],
        mobile = json['mobile'],
        id=int.parse(json['id'])
  ;
}