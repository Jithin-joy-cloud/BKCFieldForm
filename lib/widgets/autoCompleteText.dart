import 'package:bkc_field_form/controllers/user_controller.dart';
import 'package:bkc_field_form/main.dart';
import 'package:bkc_field_form/models/general_details.dart';
import 'package:bkc_field_form/screens/forms/general_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutoCompleteCustom extends StatefulWidget {
  final String hint;
  final TextInputType inputType;
  final double height;

  const AutoCompleteCustom({
    Key? key,
    required this.hint,
    required this.inputType,
    required this.height,
  }) : super(key: key);

  @override
  AutoCompleteCustomScreen createState() => AutoCompleteCustomScreen();
}

class AutoCompleteCustomScreen extends State<AutoCompleteCustom> {
  List<General>? generalList;

  @override
  void initState() {
    objectBox.getGeneralDetails().then((value) {
      generalList = [General()];
      generalList!.clear();
      if (value!.isNotEmpty) {
        generalList!.addAll(value);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<General>(optionsMaxHeight: 50,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<General>.empty();
        } else {
          return generalList!.where((word) => word.enrolmentId
              .toLowerCase()
              .startsWith(textEditingValue.text.toLowerCase()));
        }
      },
      displayStringForOption: (General general) => general.enrolmentId,

      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
         // initialValue: widget.in.general.enrolmentId,
          controller: textEditingController,
          decoration: showDecoration(widget.height, "EsEnrolment ID"),
          focusNode: focusNode,keyboardType: TextInputType.text,
          maxLines: 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLength: 14,inputFormatters: [UpperCaseTextFormatter()],
          validator: (value) {
            if (value!.length < 2 || value.length > 14) {
              return "Please enter a valid EsEnrolment ID";
            } else {
              return null;
            }
          },
        );
      },
      onSelected: (General selection) {
       // widget.formController.general.enrolmentId = selection.enrolmentId;
      },
    );
  }
}

InputDecoration showDecoration(double size, String hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      horizontal: size * .022,
    ),
    hintText: hint,
    counterText: "",
    labelText: hint,
    // hintStyle: TextStyle(color: Theme.of(context).hintColor),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          size * .05,
        ),
        borderSide: const BorderSide()),
    fillColor: Colors.white,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(size * .03),
      borderSide: const BorderSide(
        color: Color(0xff128841),
        width: 2.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(size * .03),
      borderSide: const BorderSide(
        color: Color(0xff128841),
        width: 2.0,
      ),
    ),
  );
}
