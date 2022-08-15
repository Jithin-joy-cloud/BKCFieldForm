import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/main.dart';
import 'package:bkc_field_form/models/completeForm.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/screens/forms/formOne.dart';
import 'package:bkc_field_form/screens/forms/formThree.dart';
import 'package:bkc_field_form/screens/forms/formTwo.dart';
import 'package:bkc_field_form/screens/forms/general_details.dart';
import 'package:bkc_field_form/screens/forms/house_details.dart';
import 'package:bkc_field_form/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class EditFormScreen extends StatefulWidget {
  final CompleteForm completeForm;

  const EditFormScreen({
    Key? key,
    required this.completeForm,
  }) : super(key: key);

  @override
  EditFormScreenState createState() => EditFormScreenState();
}

class EditFormScreenState extends StateMVC<EditFormScreen> {
  late GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late FormController formController;

  EditFormScreenState() : super(FormController()) {
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
    formController.house = widget.completeForm.house.target!;
    formController.general = widget.completeForm.general.target!;
    formController.buildComponentOne =
        widget.completeForm.buildComponentOne.target!;
    formController.buildComponentTwo =
        widget.completeForm.buildComponentTwo.target!;
    formController.buildComponentThree =
        widget.completeForm.buildComponentThree.target!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = currentDevice.value.height;
    return WillPopScope(
        onWillPop: () {
          setState(() {});
          return formController.customPop(context);
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          drawer: DrawerWidget(
            height: height,
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColorDark,
            title: Image.asset('assets/img/logo.png'),
          ),
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween(
                      begin: const Offset(5.0, 0.0),
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
                                  .updateToLocal(context, objectBox,
                                      widget.completeForm.id)
                                  .then((value) {
                                /*Navigator.pushNamed(
                                context,
                                '/localForm',
                              );*/
                                Navigator.pushNamed(context, '/result',
                                    arguments: formController);
                              });
                            },
                            child: Center(
                              child: Text(
                                'Save',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).cardColor),
                              ),
                            )),
                      )
                    : const SizedBox(),
              ),
              Positioned(
                bottom: height * .01,
                right: height * .01,
                child: formController.currentIndex < _fragments.length - 1
                    ? Container(      height: height * .05,
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
