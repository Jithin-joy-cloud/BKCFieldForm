import 'package:bkc_field_form/models/user.dart';
import 'package:bkc_field_form/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart' as repository;
import '../utils/overlay.dart';
import 'package:bkc_field_form/utils/sharedPreference.dart' as pref;

class UserController extends ControllerMVC {
  User user = User();
  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  late OverlayEntry loader;

  UserController() {
    // scaffoldKey = GlobalKey<ScaffoldState>();
    // userFormKey = GlobalKey<FormState>();
  }

  void register(BuildContext context, final size) {
    loader = ProgressHelper.overlayLoader(context);
    FocusManager.instance.primaryFocus!.unfocus();
    userFormKey.currentState!.save();
    /*userFormKey.currentState!.validate()*/
    if (validateRegister(context)) {
      Overlay.of(context)!.insert(loader);
      repository.register(user).then((value) {
        ProgressHelper.hideLoader(loader);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }).catchError((e) {
        ProgressHelper.hideLoader(loader);
        showSnackBar(context, e.toString());
      });
    }
  }
  void updateProfile(BuildContext context) {
    Navigator.of(context).pop();
    loader = ProgressHelper.overlayLoader(context);
    userFormKey.currentState!.save();
    user.id = currentUser.value.id;
    user.username=  user.username.isEmpty ? currentUser.value.username: user.username;
    user.phoneNumber= user.phoneNumber.isEmpty ? currentUser.value.phoneNumber: user.phoneNumber;
    user.employeeID=  user.employeeID.isEmpty ? currentUser.value.employeeID: user.employeeID;

    if (userFormKey.currentState!.validate()) {
      Overlay.of(context)!.insert(loader);
      repository.update(user).then((value) {
        ProgressHelper.hideLoader(loader);
        showSnackBar(context, "Profile Updated");
        setState(() { });
      }).catchError((e) {
        ProgressHelper.hideLoader(loader);
        showSnackBar(context, e.toString());
      });
    }
  }
  void login(BuildContext context) {
    loader = ProgressHelper.overlayLoader(context);
    FocusManager.instance.primaryFocus!.unfocus();
    userFormKey.currentState!.save();
    /*userFormKey.currentState!.validate()*/
    if (validateLogin(context)) {
      Overlay.of(context)!.insert(loader);
      repository.login(user).then((value) {
        ProgressHelper.hideLoader(loader);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }).catchError((e) {
        ProgressHelper.hideLoader(loader);
        showSnackBar(context, e.toString());
      });
    }
  }

  logout(BuildContext context) {
    pref.logoutWithCache().then((value) => {
          if (value == "Pref cleared")
            {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false)
            }
          else
            {showSnackBar(context, "Something went wrong")}
        });
  }

  /*String? validateEmail(String input) {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input);
    if (!emailValid) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }
  String? validateUsername(String input) {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input);
    if (!emailValid) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }
  String? validatePhone(String input) {
    if (input.length != 10) {
      return "Enter a valid mobile";
    } else {
      return null;
    }
  }*/

  bool validateLogin(BuildContext context) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(user.email);
    if (!emailValid) {
      showSnackBar(context, "enter valid email address");
      return false;
    } else if (user.password.length < 8) {
      showSnackBar(context, "Password must be at least 8 characters");
      return false;
    }
    return true;
  }

  void showSnackBar(BuildContext context, String msg) {
    scaffoldMessengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(msg),
      ));
  }

  bool validateRegister(BuildContext context) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(user.email);
    bool phoneValid = RegExp(r"^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$")
        .hasMatch(user.phoneNumber);
    if (user.username.length < 3 || user.username.length > 12) {
      showSnackBar(context, "enter valid username");
      return false;
    } else if (user.employeeID.length != 4) {
      showSnackBar(context, "enter valid employee id");
      return false;
    } else if (!phoneValid) {
      showSnackBar(context, "enter valid phone number");
      return false;
    } else if (!emailValid) {
      showSnackBar(context, "enter valid email address");
      return false;
    } else if (user.password.length < 8) {
      showSnackBar(context, "Password must be at least 8 characters");
      return false;
    }
    return true;
  }

}
