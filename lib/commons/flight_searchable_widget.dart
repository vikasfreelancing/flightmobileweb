import 'package:flightmobileweb/model/flight_stop_ticket.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
class FlightSearchableWidget extends StatefulWidget {
  final List<DropdownMenuItem> items;
  final Function onChanged;
  final String hint;
  final String searchHint;
  final Function validator;
  FlightSearchableWidget({this.items,this.onChanged,this.hint,this.searchHint,this.validator});
  @override
  _FlightSearchableWidgetState createState() => _FlightSearchableWidgetState();
}

class _FlightSearchableWidgetState extends State<FlightSearchableWidget> {
  @override
  Widget build(BuildContext context) {
    return SearchableDropdown.single(
      validator: widget.validator,
      items: widget.items,
      onChanged: widget.onChanged,
      isCaseSensitiveSearch: true,
      hint: widget.hint,
      searchHint: widget.searchHint,
      doneButton: "Done",
      displayItem: (item, selected) {
        return (Row(children: [
          selected
              ? Icon(
            Icons.radio_button_checked,
            color: Colors.grey,
          )
              : Icon(
            Icons.radio_button_unchecked,
            color: Colors.grey,
          ),
          SizedBox(width: 7),
          Expanded(
            child: item,
          ),
        ]));
      },
      isExpanded: true,
    );
  }
}
