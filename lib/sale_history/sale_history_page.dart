import 'package:flightmobileweb/commons/commons.dart';
import 'package:flightmobileweb/model/SaleFlightModel.dart';
import 'package:flightmobileweb/sale_history/sale_history_card.dart';
import 'package:flutter/material.dart';

class SaleHistoryPage extends StatefulWidget {
  final List<SaleFlightTicketModel> history;
  SaleHistoryPage({this.history});
  @override
  _SaleHistoryPageState createState() => _SaleHistoryPageState();
}

class _SaleHistoryPageState extends State<SaleHistoryPage>
    with TickerProviderStateMixin {
  AnimationController cardEntranceAnimationController;
  List<Animation> ticketAnimations;
  Animation fabAnimation;

  @override
  void initState() {
    super.initState();
    cardEntranceAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1100),
    );
    ticketAnimations = widget.history.map((stop) {
      int index = widget.history.indexOf(stop);
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
    if(widget.history==null || widget.history.length==0)
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
    return widget.history.map((stop) {
      int index = widget.history.indexOf(stop);
      return GestureDetector(
        onTap: () {
          setState(() {
          });
        },
        child: AnimatedBuilder(
          animation: cardEntranceAnimationController,
          child: SaleHistoryCard(saleFlightTicketModel: stop,),
          builder: (context, child) => new Transform.translate(
            offset: Offset(0.0, ticketAnimations[index].value),
            child: child,
          ),
        ),
      );
    });
  }
}
