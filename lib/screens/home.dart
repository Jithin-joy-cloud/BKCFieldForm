import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/db/formObjectBox.dart';
import 'package:bkc_field_form/models/completeForm.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/models/general_details.dart';
import 'package:bkc_field_form/models/house_details.dart';
import 'package:bkc_field_form/screens/forms/general_details.dart';
import 'package:bkc_field_form/screens/forms/house_details.dart';
import 'package:bkc_field_form/screens/forms/result.dart';
import 'package:bkc_field_form/utils/remoteConfig.dart';
import 'package:bkc_field_form/utils/style.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:objectbox/objectbox.dart';
import '../main.dart';
import '../utils/helper.dart';
import '../utils/overlay.dart';
import '../widgets/drawer.dart';
import 'forms/formOne.dart';
import 'forms/formThree.dart';
import 'forms/formTwo.dart';

class HomeScreen extends StatefulWidget {
  final FormController? formController;

  const HomeScreen([this.formController]);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends StateMVC<HomeScreen> {
  late GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final height = currentDevice.value.height;

  late FormController formController;

  HomeScreenState() : super(FormController()) {
    formController = controller as FormController;
  }

  late final List<Widget> _fragments = [
    GeneralDetails(formController: formController),
    HouseDetail(formController: formController),
    FormOne(formController: formController),
    FormTwo(formController: formController),
    FormThree(formController: formController),
  ];

  @override
  void initState() {

    formController =
        widget.formController == null ? formController : widget.formController!;
    super.initState();
  }

  getExcel() async {
    await formController.pickFile(context).then((value) {
      if (value == null) {
        return;
      } else {
        formController.general = value[0];
        formController.house = value[1];
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => HomeScreen(formController)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          setState(() {});
          return formController.customPop(context);
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColorDark,
            title: Image.asset('assets/img/logo.png'),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: height * .03),
                child: InkWell(
                  onTap: () {
                    getExcel();
                  },
                  child: formController.currentIndex==0?Icon(
                    Icons.file_upload_outlined,
                    color: Theme.of(context).cardColor,
                  ):const SizedBox(),
                ),
              )
            ],
          ),
          resizeToAvoidBottomInset: false,
          drawer: DrawerWidget(
            height: height,
          ),
          body: Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween(
                      begin: const Offset(1.0, 0.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(animation),
                    child: child,
                  );
                },
                child: _fragments[formController.currentIndex],
              ),
              Positioned(
                bottom: height * .01,
                left: height * .01,
                child: formController.currentIndex > 0
                    ? Container(
                        height: height * .05,
                        width: height * .15,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(height * .03)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColorDark,
                              ]),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent),
                          onPressed: () {
                            formController.backstack
                                .removeAt(formController.backstack.length - 1);
                            formController.navigateBack(
                                formController.backstack[
                                    formController.backstack.length - 1]);
                            setState(() {});
                          },
                          child: Center(
                            child: Text(
                              'Previous',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Theme.of(context).cardColor),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              Positioned(
                bottom: height * .01,
                right: height * .01,
                child: formController.currentIndex == _fragments.length - 1
                    ? Container(
                        height: height * .05,
                        width: height * .15,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(height * .03)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColorDark,
                              ]),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent),
                          onPressed: () {
                            formController
                                .saveToLocal(context, objectBox)
                                .then((value) {
                              Navigator.pushNamed(context, '/result',
                                  arguments: formController);
                            });
                          },
                          child: Center(
                            child: Text(
                              'Save',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Theme.of(context).cardColor),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              Positioned(
                bottom: height * .01,
                right: height * .01,
                child: formController.currentIndex < _fragments.length - 1
                    ? Container(
                        height: height * .05,
                        width: height * .15,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(height * .03)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColorDark,
                              ]),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent),
                          onPressed: () {
                            //  formController.currentIndex++;
                            formController.navigateTo(context);
                            setState(() {});
                          },
                          child: Center(
                            child: Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Theme.of(context).cardColor),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              )
            ],
          ),
        ));
  }
}
