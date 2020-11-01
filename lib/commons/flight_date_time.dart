import 'package:flightmobileweb/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
class FlightDateTime extends StatefulWidget {
  final Function onChanged;
  final Function validator;
  FlightDateTime({this.validator,this.onChanged});
  @override
  _FlightDateTimeState createState() => _FlightDateTimeState();
}

class _FlightDateTimeState extends State<FlightDateTime> {
  final format = DateUtil.format;
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      validator:widget.validator,
      format: format,
      decoration: InputDecoration(
        labelText: "Date",
      ),
      onChanged:widget.onChanged,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    );
  }

}
