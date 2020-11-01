class BookingModel
{
  BookingModel({this.flightId,this.name,this.age,this.mobile,this.userId});
  String flightId;
  String name;
  int age;
  String mobile;
  String userId;
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'age': age,
    'name': name,
    'mobile': mobile,
    'flightId':flightId
  };
BookingModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        age = int.parse(json['dob']),
        name = json['name'],
        mobile = json['mobile'],
        flightId=json['flightId']
  ;
}