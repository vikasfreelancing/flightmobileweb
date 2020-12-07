import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
class DropDown extends StatefulWidget {
  DropDown(this.items,this.message,this.validationMessage,this.onChanged);
  final Function onChanged;
  final List<DropdownMenuItem> items;
  final String validationMessage;
  final String message;
  //final FlightFilter flightFilter;
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return SearchableDropdown.single(
      //validator: (value)=>(value==null)?'${widget.validationMessage}':null,
      items: widget.items,
      onChanged: widget.onChanged,
      isCaseSensitiveSearch: true,
      hint: "${widget.message}",
      //searchHint: "${widget.message}",
      //menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
      //dialogBox: false,
      displayItem: (item, selected) {
        return (
            Row(children: [
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
