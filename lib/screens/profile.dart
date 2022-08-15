import 'dart:io';
import 'dart:ui';
import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/controllers/user_controller.dart';
import 'package:bkc_field_form/db/formObjectBox.dart';
import 'package:bkc_field_form/models/completeForm.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/models/general_details.dart';
import 'package:bkc_field_form/models/house_details.dart';
import 'package:bkc_field_form/repository/user_repository.dart';
import 'package:bkc_field_form/screens/forms/general_details.dart';
import 'package:bkc_field_form/screens/forms/house_details.dart';
import 'package:bkc_field_form/screens/forms/result.dart';
import 'package:bkc_field_form/utils/style.dart';
import 'package:bkc_field_form/widgets/textFieldCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:objectbox/objectbox.dart';
import '../main.dart';
import '../widgets/authenticationClipper.dart';
import '../widgets/drawer.dart';
import 'forms/formOne.dart';
import 'forms/formThree.dart';
import 'forms/formTwo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends StateMVC<ProfileScreen> {
  late UserController userController;
  final height = currentDevice.value.height;
  final _mobileFormatter = _NumberTextInputFormatter();

  ProfileScreenState() : super(UserController()) {
    userController = controller as UserController;
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Update",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(height * .02),
            child: Material(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(height * .02)),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Form(
                  key: userController.userFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: height * .03,
                      ),
                      Text(
                        "Update User Profile",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: height * .025,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Color(0xff128841)),
                        initialValue: currentUser.value.username,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        maxLength: 15,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (input) {
                          userController.user.username = input;
                        },
                        validator: (value) {
                          if (value!.length < 3 || value.length > 12) {
                            return "Please enter a valid username";
                          } else {
                            return null;
                          }
                        },
                        decoration: showDecoration(height, "Username *"),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Color(0xff128841)),
                        initialValue: currentUser.value.phoneNumber,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 15,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          _mobileFormatter,
                        ],
                        onChanged: (input) {
                          userController.user.phoneNumber = input;
                        },
                        validator: (value) {
                          bool phoneValid = RegExp(
                                  r"^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$")
                              .hasMatch(value!);
                          if (!phoneValid) {
                            return "Please enter a valid phone number";
                          } else {
                            return null;
                          }
                        },
                        decoration: showDecoration(height, "Phone Number *"),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Color(0xff128841)),
                        initialValue: currentUser.value.employeeID,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        maxLength: 15,                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        onChanged: (input) {
                          userController.user.employeeID = input;
                        },
                        validator: (value) {
                          if (value!.length != 4) {
                            return "Please enter a valid employee Id";
                          } else {
                            return null;
                          }
                        },
                        decoration: showDecoration(height, "Employee Id *"),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      TextFormField(
                        readOnly: true,
                        style: const TextStyle(color: Color(0xff128841)),
                        initialValue: currentUser.value.email,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        maxLength: 15,
                        onChanged: (input) {
                          userController.user.employeeID = input;
                        },
                        decoration: showDecoration(height, "Email"),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancel ",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: height * .02,
                                    fontWeight: FontWeight.bold),
                              )),
                          TextButton(
                              onPressed: () {
                                userController.updateProfile(context);
                              },
                              child: Text(
                                "Update",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: height * .02,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: anim,
          curve: curve,
        );
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = currentDevice.value.height;
    return MaterialApp( debugShowCheckedModeBanner: false,
      theme: Style.themeData(false, context),
      scaffoldMessengerKey: userController.scaffoldMessengerKey,
      home: Scaffold(
        key: userController.scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,  leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).cardColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Image.asset('assets/img/logo.png'),
        ),

        body: Stack(
          overflow: Overflow.visible,
          children: [
            ClipPath(
              clipper: CustomPath(),
              child: Container(
                height: height * .8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(.9),
                      Theme.of(context).primaryColorDark,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * .06,
              left: height * .01,
              right: height * .04,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height * .04,
                        color: Theme.of(context).cardColor),
                  ),
                  InkWell(
                    onTap: () {
                      showCustomDialog(context);
                    },
                    child: Icon(
                      Icons.edit_calendar,
                      size: height * .04,
                      color: Theme.of(context).cardColor,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: height * .19,
              left: 0,
              right: 0,
              child: Align(
                child: CircleAvatar(
                  radius: height * .05,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.account_circle,
                    size: height * .1,
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * .39,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  ListTile(
                      leading: Icon(
                        Icons.account_circle_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Name :",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: height * .02,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        currentUser.value.username,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: height * .02,
                            fontWeight: FontWeight.bold),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.mail_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Email :",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: height * .02,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        currentUser.value.email,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: height * .02,
                            fontWeight: FontWeight.bold),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.confirmation_number_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Employee Id :",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: height * .02,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        currentUser.value.employeeID,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: height * .02,
                            fontWeight: FontWeight.bold),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.call,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Phone Number :",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: height * .02,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        currentUser.value.phoneNumber,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: height * .02,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 200,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.zero, top: Radius.circular(height * .02)),
                  ),
                  elevation: 10,
                  child: ListTile(
                    onTap: () {
                      Widget continueButton = TextButton(
                        child: const Text("Continue"),
                        onPressed: () {
                          UserController().logout(context);
                        },
                      );
                      Widget cancelButton = TextButton(
                        child: const Text("Cancel"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                      );
                      AlertDialog alert = AlertDialog(
                        title: const Text(
                          "Logout",
                        ),
                        content: const Text(
                          "Are you sure you want to logout?",
                        ),
                        actions: [
                          cancelButton,
                          continueButton,
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    leading: Icon(
                      Icons.logout,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: height * .02,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
