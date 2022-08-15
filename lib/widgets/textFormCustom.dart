import 'package:bkc_field_form/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormCustom extends StatefulWidget {
  final String hint;
  final TextInputType inputType;
  final UserController userController;
  final bool isPassword;
  final double height;

  const TextFormCustom({
    Key? key,
    required this.hint,
    required this.inputType,
    required this.userController,
    required this.isPassword,
    required this.height,
  }) : super(key: key);

  @override
  TextFormCustomScreen createState() => TextFormCustomScreen();
}

class TextFormCustomScreen extends State<TextFormCustom> {
  bool isVisible = false;
  final _mobileFormatter = _NumberTextInputFormatter();

  bool _showPassword() {
    setState(() {
      isVisible = !isVisible;
    });
    return isVisible;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height * .06,
      child: TextFormField(style:  TextStyle(color: Theme.of(context).primaryColor),
        keyboardType: widget.inputType,
        obscureText: widget.isPassword ? !isVisible : false,
        maxLines: 1,
        inputFormatters: widget.inputType == TextInputType.phone
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                _mobileFormatter,
              ]
            : null,
        maxLength: getLength(widget.hint),
        onSaved: (input) {
          getValue(widget.hint, input!, widget.userController);
        },
        /* validator: (input) {
          return validate(widget.hint, input!, widget.userController);
        },*/
        decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? InkWell(
                    onTap: _showPassword,
                    child: isVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off))
                : const SizedBox(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: widget.height * .022,
            ),
            hintText: widget.hint,
            counterText: "",
            labelText: widget.hint,
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.height * .03,
                ),
                borderSide: BorderSide(color: Theme.of(context).errorColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.height * .03,
                ),
                borderSide: const BorderSide()), focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Color(0xff128841),
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Color(0xff128841),
          width: 2.0,
        ),
      ),
            /* focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff707070))),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff707070),),
            )*/
            ),
      ),
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
      maxLength = 14;
      break;
  }
  return maxLength;
}

void getValue(String hint, String input, UserController userController) {
  if (input != null) {
    switch (hint) {
      case "Username":
        userController.user.username = input;
        break;
      case "Employee ID":
        userController.user.employeeID = input;
        break;
      case "Phone number":
        userController.user.phoneNumber = input;
        break;
      case "Email":
        userController.user.email = input;
        break;
      case "Password":
        userController.user.password = input;
        break;

      default:
        {
          if (kDebugMode) {
            print("Something went wrong");
          }
        }
        break;
    }
  }
}

/*
String? validate(String hint, String input, UserController userController) {
  String? msg;
  if (input != null) {
    switch (hint) {
      case "Username":
        msg = userController.validateUsername(input);
        break;
      case "Employee ID":
        msg = userController.validateUsername(input);
        break;
      case "Phone number":
        msg = userController.validatePhone(input);
        break;
      case "Email":
        msg = userController.validateEmail(input);
        break;
      case "Password":
        msg = userController.validateUsername(input);
        break;

      default:
        {
          if (kDebugMode) {
            print("Something went wrong");
          }
        }
        break;
    }
  }
  return msg;
}
*/
class _NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
