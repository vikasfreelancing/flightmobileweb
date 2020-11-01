class FlightStop {
  String fromAirport;
  String toAirport;
  String departureDate;
  String duration;
  String price;
  String arrivalDate;

  FlightStop(this.fromAirport, this.toAirport, this.departureDate, this.duration, this.price,
      this.arrivalDate);
}

class TicketFlightStop {
  String from;
  String fromShort;
  String to;
  String toShort;
  String flightNumber;

  TicketFlightStop(
      this.from, this.fromShort, this.to, this.toShort, this.flightNumber);
}
