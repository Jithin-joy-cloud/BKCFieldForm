import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/main.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/widgets/alertDialogue.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/completeForm.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LocalFormScreen extends StatefulWidget {
  const LocalFormScreen({
    Key? key,
  }) : super(key: key);

  @override
  LocalFormScreenState createState() => LocalFormScreenState();
}

class LocalFormScreenState extends StateMVC<LocalFormScreen> {
  late Stream<List<CompleteForm>> formStream;
  final height = currentDevice.value.height;
  final size = currentDevice.value.height;
  late FormController formController;
  bool isListEmpty = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LocalFormScreenState() : super(FormController()) {
    formController = controller as FormController;
  }

/*
  changeState(bool value) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        isListEmpty = value;
      });
    });
  }
*/

  @override
  void initState() {
    formStream = objectBox.getAllForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back_ios, color: Theme.of(context).cardColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Image.asset('assets/img/logo.png'),
        ),
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<List<CompleteForm>>(
            stream: formStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.active &&
                  snapshot.hasData &&
                  snapshot.data!.isNotEmpty) {
                final forms = snapshot.data;
                return Stack(
                  children: [
                    ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: forms!.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Slidable(
                            child: Container(color: Theme.of(context).primaryColor.withOpacity(.4),
                              margin: EdgeInsets.symmetric(horizontal: 0,vertical: height * .001),
                              child: Padding(
                                padding: EdgeInsets.all(size * .02),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Inspection date: ${forms[index].general.target!.inspectionDate.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      SizedBox(
                                        height: size * .01,
                                      ),
                                      Text(
                                        "Evaluator name: ${forms[index].general.target!.evaluatorName.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      SizedBox(
                                        height: size * .01,
                                      ),
                                      Text(
                                        "Site name: ${forms[index].house.target!.site.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            startActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      Navigator.pushNamed(context, '/editForm',
                                          arguments: forms[index]);
                                    },
                                    backgroundColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.2),
                                    foregroundColor:
                                        Theme.of(context).primaryColor,
                                    icon: Icons.edit_calendar,
                                    label: 'Edit',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      Widget continueButton = TextButton(
                                        child: const Text("Upload"),
                                        onPressed: () {
                                          formController.upload(
                                              _scaffoldKey.currentContext!,
                                              forms[index]);
                                          Navigator.of(
                                                  _scaffoldKey.currentContext!)
                                              .pop();
                                        },
                                      );
                                      Widget cancelButton = TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () async {
                                          Navigator.of(
                                                  _scaffoldKey.currentContext!)
                                              .pop();
                                        },
                                      );
                                      AlertDialog alert = AlertDialog(
                                        title: const Text(
                                          "Upload",
                                        ),
                                        content: const Text(
                                          "Are you sure you want to upload this file?",
                                        ),
                                        actions: [
                                          cancelButton,
                                          continueButton,
                                        ],
                                      );
                                      showDialog(
                                        context: _scaffoldKey.currentContext!,
                                        builder:
                                            (BuildContext dialogueContext) {
                                          return alert;
                                        },
                                      );
                                    },
                                    backgroundColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.2),
                                    foregroundColor:
                                        Theme.of(context).primaryColor,
                                    icon: Icons.cloud_upload_sharp,
                                    label: 'Upload',
                                  ),
                                ]),
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      Widget continueButton = TextButton(
                                        child: const Text("Delete"),
                                        onPressed: () {
                                          objectBox.deleteFormWithId(
                                              forms[index].id);
                                          Navigator.of(
                                                  _scaffoldKey.currentContext!)
                                              .pop();
                                        },
                                      );
                                      Widget cancelButton = TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () async {
                                          Navigator.of(
                                                  _scaffoldKey.currentContext!)
                                              .pop();
                                        },
                                      );
                                      AlertDialog alert = AlertDialog(
                                        title: const Text(
                                          "Delete",
                                        ),
                                        content: const Text(
                                          "Are you sure you want to delete this file?",
                                        ),
                                        actions: [
                                          cancelButton,
                                          continueButton,
                                        ],
                                      );
                                      showDialog(
                                        context: _scaffoldKey.currentContext!,
                                        builder:
                                            (BuildContext dialogueContext) {
                                          return alert;
                                        },
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.1),
                                    foregroundColor:
                                        Theme.of(context).errorColor,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ]));
                      },
                      scrollDirection: Axis.vertical,
                      // separatorBuilder: (BuildContext context, int index) {
                      //   return Divider(
                      //     color: Theme.of(context).primaryColor,
                      //     thickness: .1,
                      //   );
                      // },
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: size * .03, right: size * .03),
                        child: FloatingActionButton(
                          elevation: 5,
                          onPressed: () {
                            Widget continueButton = TextButton(
                              child: const Text("Delete"),
                              onPressed: () {
                                objectBox.deleteForm();
                                Navigator.of(_scaffoldKey.currentContext!)
                                    .pop();
                              },
                            );
                            Widget cancelButton = TextButton(
                              child: const Text("Cancel"),
                              onPressed: () async {
                                Navigator.of(_scaffoldKey.currentContext!)
                                    .pop();
                              },
                            );
                            AlertDialog alert = AlertDialog(
                              title: const Text(
                                "Delete",
                              ),
                              content: const Text(
                                "Are you sure you want to delete all the forms",
                              ),
                              actions: [
                                cancelButton,
                                continueButton,
                              ],
                            );
                            showDialog(
                              context: _scaffoldKey.currentContext!,
                              builder: (BuildContext dialogueContext) {
                                return alert;
                              },
                            );
                          },
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.delete,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return SizedBox(
                  height: size / 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "No forms available",
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                        IconButton(
                          icon: Icon(Icons.document_scanner,
                              color: Theme.of(context).hintColor),
                          iconSize: size * .1,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            }));
  }
}
