import 'dart:ui';

import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/controllers/user_controller.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCustom extends StatefulWidget {
  final String hint;
  final TextInputType inputType;
  final ValueSetter<String> callback;

  const TextFieldCustom({
    Key? key,
    required this.hint,
    required this.inputType,
    required this.callback,
  }) : super(key: key);

  @override
  TextFieldCustomScreen createState() => TextFieldCustomScreen();
}

class TextFieldCustomScreen extends State<TextFieldCustom> {
  final height = currentDevice.value.height;

  //final _mobileFormatter = _NumberTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: widget.inputType,
        maxLines: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: 14,
        /*    inputFormatters: widget.inputType == TextInputType.phone
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                _mobileFormatter,
              ]
            : null,*/
        onSaved: (input) {
          widget.callback(input!);
        },
        validator: (value) {
          if (value!.length < 4) {
            return 'Please enter a value ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: height * .022,
            ),
            hintText: widget.hint,
            counterText: "",
            labelText: widget.hint,
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  height * .05,
                ),
                borderSide: const BorderSide())),

    );
  }
}

int getLength(String hint) {
  int maxLength = 25;
  switch (hint) {
    case "Employee ID":
      maxLength = 4;
      break;
    case "Phone number":
      maxLength = 10;
      break;
  }
  return maxLength;
}
