class SaleFlightTicketModel {
  SaleFlightTicketModel();
  int fromAirport;
  String fromAirportName;
  String toAirportName;
  int toAirport;
  DateTime departureDate;
  DateTime reachingTime;
  DateTime bookdate;
  double price;
  bool freeLeg;
  int seats;
  int userId;
  bool isfreeleg = false;
  double priceperseat;
  Map<String, dynamic> toJson() => {
    'isfreeleg':isfreeleg,
    'priceperseat':priceperseat,
    'bookedbyuserid':userId,
    'startairportid': fromAirport,
    'endairportid': toAirport,
    'starttime': departureDate.toIso8601String(),
    'endtime':reachingTime.toIso8601String(),
    //'freeLeg':false,
    'numberofseats':seats
  };
  SaleFlightTicketModel.fromJson(Map<String, dynamic> json)
      : fromAirport = json['startairportid'],
        toAirport = json['endairportid'],
        departureDate = DateTime.parse(json['starttime']),
        price = json['priceperseat'],
        freeLeg=json['isfreeleg'],
        reachingTime=DateTime.parse(json['endtime']),
        seats=json['availableseats'],
        bookdate=DateTime.parse(json['bookdate'])
  ;
}