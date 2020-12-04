import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flightmobileweb/commons/commons.dart';
class FlightDate extends StatefulWidget {
  FlightDate(this.label,this.validationMessage,this.onChanged);
  final Function onChanged;
  final String validationMessage;
  final String label;
  @override
  _FlightDateState createState() => _FlightDateState();
}

class _FlightDateState extends State<FlightDate> {
  @override
  Widget build(BuildContext context) {
    final format = DateUtil.format;
    return DateTimeField(
      validator:(value)=>value==null?'${widget.validationMessage}':null,
      format: format,
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      onChanged: widget.onChanged,
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
