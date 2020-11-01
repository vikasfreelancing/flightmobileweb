// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:flightmobileweb/commons.dart';
// import 'package:flightmobileweb/model/flight_stop_ticket.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// class BookFlightInput extends StatefulWidget {
//   final FlightFilter flightFilter;
//   BookFlightInput({this.flightFilter});
//   @override
//   BookFlightInputState createState() {
//     return new BookFlightInputState();
//   }å
// }
//
// class BookFlightInputState extends State<BookFlightInput>
//     with TickerProviderStateMixin {
//   AnimationController textInputAnimationController;
//
//   @override
//   void initState() {
//     super.initState();
//     textInputAnimationController = new AnimationController(
//         vsync: this, duration: Duration(milliseconds: 800));
//   }
//
//   @override
//   void dispose() {
//     textInputAnimationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
//               child: TextFormField(
//                 onChanged: (fromCity){
//                   widget.flightFilter.fromCity = fromCity;
//                 },
//                  decoration: InputDecoration(
//                   icon: Icon(Icons.flight_takeoff, color: Colors.blue),
//                   labelText: "From",
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
//               child: TextFormField(
//                 onChanged: (toCity){
//                   widget.flightFilter.toCity = toCity;
//                 },
//                 decoration: InputDecoration(
//                   icon: Icon(Icons.flight_land, color: Colors.blue),
//                   labelText: "To",
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
//               child: TextFormField(
//                 onChanged: (seats){
//                   widget.flightFilter.seats =int.parse(seats);
//                 },
//                 decoration: InputDecoration(
//                   icon: Icon(Icons.person, color: Colors.blue),
//                   labelText: "Passengers",
//                 ),
//               ),
//             ),
//             Row(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(right: 16.0),
//                   child: Icon(Icons.date_range, color: Colors.blue),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 16.0),
//                     child: basicDateField(context),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   CurvedAnimation _buildInputAnimation({double begin, double end}) {
//     return new CurvedAnimation(
//         parent: textInputAnimationController,
//         curve: Interval(begin, end, curve: Curves.linear));
//   }
//   Widget basicDateField(BuildContext context) {
//     final format = DateUtil.format;
//     return DateTimeField(
//       format: format,
//       decoration: InputDecoration(
//         labelText: "Date",
//       ),
//       onChanged: (date) {
//          widget.flightFilter.date =date;
//       },
//       onShowPicker: (context, currentValue) {
//         return showDatePicker(
//             context: context,
//             firstDate: DateTime(1900),
//             initialDate: currentValue ?? DateTime.now(),
//             lastDate: DateTime(2100));
//       },
//     );
//   }
// }
