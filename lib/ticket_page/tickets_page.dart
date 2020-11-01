import 'package:flightmobileweb/commons/commons.dart';
import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flightmobileweb/ticket_page/ticket_card.dart';
import 'package:flutter/material.dart';

class TicketsPage extends StatefulWidget {
  final List<FlightStopTicket> tickets;
  TicketsPage({this.tickets});
  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage>
    with TickerProviderStateMixin {
  List<FlightStopTicket> stops ;
  AnimationController cardEntranceAnimationController;
  List<Animation> ticketAnimations;
  Animation fabAnimation;

  @override
  void initState() {
    stops = widget.tickets;
    super.initState();
    cardEntranceAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1100),
    );
    ticketAnimations = stops.map((stop) {
      int index = stops.indexOf(stop);
      double start = index * 0.01;
      double duration = 0.6;
      double end = duration + start;
      return new Tween<double>(begin: 800.0, end: 0.0).animate(
          new CurvedAnimation(
              parent: cardEntranceAnimationController,
              curve: new Interval(start, end, curve: Curves.decelerate)));
    }).toList();
    fabAnimation = new CurvedAnimation(
        parent: cardEntranceAnimationController,
        curve: Interval(0.7, 1.0, curve: Curves.decelerate));
    cardEntranceAnimationController.forward();
  }

  @override
  void dispose() {
    cardEntranceAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.tickets==null || widget.tickets.length==0)
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("No flights available",style: TextUtil.textStyle,),
        ),
      );
    else
    return Column(
      children: _buildTickets().toList(),
    );
  }

  Iterable<Widget> _buildTickets() {
    return stops.map((stop) {
      int index = stops.indexOf(stop);
      return GestureDetector(
        onTap: () {
          setState(() {
            stop.showDetails = !stop.showDetails;
          });
        },
        child: AnimatedBuilder(
          animation: cardEntranceAnimationController,
          child: TicketCard(stop: stop),
          builder: (context, child) => new Transform.translate(
            offset: Offset(0.0, ticketAnimations[index].value),
            child: child,
          ),
        ),
      );
    });
  }
}
