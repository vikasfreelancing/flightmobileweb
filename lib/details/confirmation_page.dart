import 'package:flightmobileweb/components/flight_bar.dart';
import 'package:flightmobileweb/components/sideMenu.dart';
import 'package:flightmobileweb/details/ticket_widget.dart';
import 'package:flightmobileweb/login/widgets/loader_hud.dart';
import 'package:flightmobileweb/model/BookingModel.dart';
import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flightmobileweb/payment/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
class ConfirmationPage extends StatefulWidget {

  ConfirmationPage({this.bookings,this.stopTicket});
  final List<BookingModel> bookings;
  final FlightStopTicket stopTicket;

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: Stack(
        children: <Widget>[
          Flight(height: 1000,screen: 'Confirm',),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 70.0),
              child: new Column(
                children: <Widget>[
                  Expanded(child: _buildConfirmationPage(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationPage(BuildContext context) {
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
                    _buildContentContainer(viewportConstraints,context),
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

  Widget _buildContentContainer(BoxConstraints viewportConstraints,BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: new ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: viewportConstraints.maxHeight - 48.0,
          ),
          child: new IntrinsicHeight(child: Column(
            children: _buildTickets(context),
          )),
        ),
      ),
    );
  }

  List<Widget> _buildTickets(BuildContext context){
    List<Widget> list = List();
    widget.bookings.forEach((booking) {
      list.add(Expanded(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlightTicketWidget(booking: booking,stopTicket: widget.stopTicket,),
      )));
    });
    list.add(confirmAndPay(context));
    return list;
  }

  void redirectToPayments() async{
    {
      String tokenizationKey = 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j';
      var request = BraintreeDropInRequest(
        tokenizationKey: tokenizationKey,
        collectDeviceData: true,
        googlePaymentRequest: BraintreeGooglePaymentRequest(
          totalPrice: '4.20',
          currencyCode: 'USD',
          billingAddressRequired: false,
        ),
        paypalRequest: BraintreePayPalRequest(
          amount: '4.20',
          displayName: 'Example company',
        ),
        cardEnabled: true,
      );
      BraintreeDropInResult result =
      await BraintreeDropIn.start(request);
    }
  }
  Widget confirmAndPay(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RaisedButton(
          disabledColor: Colors.grey,
          onPressed:() {
              setState(() {

              });
              redirectToPayments();
          },
          color: Colors.blue[900],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Confirm And Pay',
                  style: TextStyle(color: Colors.white,fontSize: 20,wordSpacing: 4,letterSpacing: 1),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color:Colors.blue[900],
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
