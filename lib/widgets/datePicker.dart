import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/utils/helper.dart';
import 'package:flutter/material.dart';

class PickDate extends StatefulWidget {
  final ValueSetter<String> dateCallback;
  final String date;
  final String initialValue;

  const PickDate({
    Key? key,
    required this.dateCallback,
    required this.date,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<PickDate> createState() => PickDateState();
}

class PickDateState extends State<PickDate> {
  final height = currentDevice.value.height;
  late var newDate = widget.date;
  int isSelected = 0;

  getDate() async {
    DateTime? newDateValue = await showDatePicker(
      context: context,
      helpText: widget.date,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2090),
    );

    setState(() {
      if (newDateValue == null) {
        isSelected = 1;
        return;
      }
      isSelected = 2;
      newDate = "${newDateValue.day}-"
          "${Helper.getMonth(newDateValue.month)}-"
          "${newDateValue.year}";
      widget.dateCallback(newDate);
    });
  }



  @override
  Widget build(BuildContext context) {
    return TextFormField( style: const TextStyle(color: Color(0xff128841)),
      readOnly: true,
      maxLines: 1,
      controller: TextEditingController(
          text: isSelected == 2 ? newDate : widget.initialValue),
      onTap: () {
        getDate();
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: height * .022,
          ),
          hintText: newDate,fillColor: Colors.white,filled: true,
          errorText: isSelected == 1
              ?widget.initialValue.isEmpty? "Please select a date":null
              : null,
          counterText: "",
          labelText: "Please select a date",
          hintStyle: TextStyle(color: Theme.of(context).hintColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                height * .05,
              ),
              borderSide: const BorderSide()),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Color(0xff128841),width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide:  const BorderSide(
              color: Color(0xff128841),
              width: 2.0,
            ),
          )),
    );
  }
}
