import 'package:flightmobileweb/commons/commons.dart';
import 'package:flightmobileweb/model/SaleFlightModel.dart';
import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class SaleHistoryCard extends StatelessWidget {
  final SaleFlightTicketModel saleFlightTicketModel;
  const SaleHistoryCard({Key key, this.saleFlightTicketModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(10.0),
      child: Material(
        elevation: 4.0,
        shadowColor: Color(0x30E5E5E5),
        color: Colors.transparent,
        child: ClipPath(
          clipper: TicketClipper(12.0),
          child: Card(
              elevation: 0.0,
              margin: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  _buildCardContentNew(),
                ],
              )),
        ),
      ),
    );
  }

  // Container _buildCardContent() {
  //   TextStyle airportNameStyle =
  //       new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);
  //   TextStyle priceStyle =
  //       new TextStyle(fontSize: 26.0, fontWeight: FontWeight.w200);
  //   // TextStyle flightNumberStyle =
  //   //     new TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500);
  //   return Container(
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisSize: MainAxisSize.max,
  //           children: <Widget>[
  //             Expanded(
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 15.0, top: 16.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 4.0),
  //                       child: Text(stop.fromAirport, style: airportNameStyle),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 4.0),
  //                       child: Text(
  //                           new DateFormat("hh:mm dd-MM-yyyy")
  //                               .format(stop.departureDate),
  //                           style: airportNameStyle),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 4.0),
  //                       child: Text("Fare", style: priceStyle),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 Padding(
  //                   padding: const EdgeInsets.only(bottom: 8.0),
  //                   child: Icon(
  //                     Icons.airplanemode_active,
  //                     color: Colors.blue,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Expanded(
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 20.0, top: 16.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 4.0),
  //                       child: Text(stop.toAirport, style: airportNameStyle),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 4.0),
  //                       child: Text(
  //                           new DateFormat("dd-MM-yyyy")
  //                               .format(stop.arrivalDate),
  //                           style: airportNameStyle),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 4.0),
  //                       child: Text(stop.price.toString(),
  //                           style: priceStyle),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //        ],
  //     ),
  //   );
  // }
  //



  Container _buildCardContentNew() {
    TextStyle airportNameStyle =
    TextUtil.textStyleSmall;
    TextStyle priceStyle =
    TextUtil.textStyleSmall;
    // TextStyle flightNumberStyle =
    //     new TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500);
    return Container(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(child: Text("Sale date ",style: TextUtil.textStyleSmall,)),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(child: Text("${DateUtil.format.format(saleFlightTicketModel.bookdate)}",style: TextUtil.textStyleSmall,))
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(saleFlightTicketModel.fromAirportName, style: airportNameStyle),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Icon(
                        Icons.airplanemode_active,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(saleFlightTicketModel.toAirportName, style: airportNameStyle),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                              DateUtil.format.format(saleFlightTicketModel.departureDate),
                          style: airportNameStyle),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        DateUtil.format.format(saleFlightTicketModel.reachingTime),
                          style: airportNameStyle),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
              
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text("Price/seat", style: priceStyle),
                    ),
                  ),
                  Expanded(child: SizedBox(),),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text("${saleFlightTicketModel.price}", style: priceStyle),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(child: Text("Seats ",style: TextUtil.textStyleSmall,)),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(child: Text("${saleFlightTicketModel.seats}",style: TextUtil.textStyleSmall,))
                ],
              ),
            )
          ]
        ),
      ),
    );
  }




}

class TicketClipper extends CustomClipper<Path> {
  final double radius;

  TicketClipper(this.radius);

  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: radius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
