import 'package:flightmobileweb/commons/commons.dart';
import 'package:flightmobileweb/flightService/flight_ticket_service.dart';
import 'package:flightmobileweb/login/widgets/loader_hud.dart';
import 'package:flightmobileweb/model/SaleFlightModel.dart';
import 'package:flightmobileweb/sale/sale_flight_input.dart';
import 'package:flightmobileweb/sale_history/sale_history_page.dart';
import 'package:flightmobileweb/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SaleFlight extends StatefulWidget {
  @override
  _SaleFlightState createState() => _SaleFlightState();
}

class _SaleFlightState extends State<SaleFlight> {
  bool loading = false;
  bool showHistory=false;
  final _formKey = GlobalKey<FormState>();
  final saleTicket = SaleFlightTicketModel();
  List<SaleFlightTicketModel> history =List();

  void loadHistory() async{
    setState(() {
      loading = true;
    });
    history = await FlightTicketService().saleFlightTicketsHistory();
    setState(() {
      showHistory = true;
      loading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderHUD(
      inAsyncCall: loading,
      child: WillPopScope(
        onWillPop: () {
          return Future(() => true);
        },
        child: new Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(8.0),
          child: DefaultTabController(
            child: new LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return Column(
                  children: <Widget>[
                    _buildContentContainer(viewportConstraints),
                  ],
                );
              },
            ),
            length: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildContentContainer(BoxConstraints viewportConstraints) {
    return Expanded(
      child: SingleChildScrollView(
        child: new ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: viewportConstraints.maxHeight - 48.0,
          ),
          child: new IntrinsicHeight(child: _buildMulticityTab()),
        ),
      ),
    );
  }

  Widget _buildMulticityTab() {
    return Column(
      children: <Widget>[
        SaleFlightInput(
          formKey: _formKey,
          saleFlightTicket: saleTicket,
        ),
        FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                setState(() {
                  //loading = true;
                  //proceedSaleTicket(saleTicket);
                  _onAlertButtonsPressed(context);
                });
              } else
                return false;
            },
            child: Icon(
              Icons.save,
              size: 36,
              //color: Colors.blue,
            )),

      if(showHistory) SaleHistoryPage(history: history,)],
    );
  }

  void proceedSaleTicket(SaleFlightTicketModel saleFlightTicketModel) async {
    setState(() {
      loading = true;
    });
    FlightTicketService().saleFlightTickets(saleFlightTicketModel).then((value) => {
    _onSuccess(context)
    }).catchError((error){
      _onFailed(context);
    }
    );
  }

  _onSuccess(context) {
    setState(() {
      loading = false;
    });
    Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: "Your Request Saved Successfully",
      buttons: [
        DialogButton(
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchPage()));
          },
          width: 120,
        )
      ],
    ).show();
  }

  _onFailed(context) {
    setState(() {
      loading = false;
    });
    Alert(
      context: context,
      type: AlertType.error,
      title: "Failed",
      desc: "Can not process your request try again",
      buttons: [
        DialogButton(
          child: Text(
            "Retry",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Confirm Flight Details",
      desc: "From Airport : ${saleTicket.fromAirportName} ,To Airport : ${saleTicket.toAirportName} ,"
          "number of seats : ${saleTicket.seats} , Departure date : ${DateUtil.format.format(saleTicket.departureDate)}" ,
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.blue,
        ),
        DialogButton(
          child: Text(
            "Confirm",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
            proceedSaleTicket(saleTicket);
          },
          color: Colors.blue,
        )
      ],
    ).show();
  }
}
