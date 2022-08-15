import 'dart:io';
import 'dart:ui';

import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/db/formObjectBox.dart';
import 'package:bkc_field_form/models/device.dart';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:share_plus/share_plus.dart';

import '../../controllers/document_controller.dart';
import '../../utils/helper.dart';

class ResultScreen extends StatefulWidget {
  final FormController formController;

  const ResultScreen({
    Key? key,
    required this.formController,
  }) : super(key: key);

  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends StateMVC<ResultScreen> {
  final size = currentDevice.value.height;
  late var pdfFile = File("");
  late FormObjectBox objectBox;
  double credit = 0;

  Future<bool> customPop() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    return Future.value(true);
  }

  void savePdf() async {
    Navigator.of(context).pop();
    documentController.showSnackBar(context, "Pdf saved");
    pdfFile = await documentController.generateTable(widget.formController);
  }

  late DocumentController documentController;

  ResultScreenState() : super(DocumentController()) {
    documentController = controller as DocumentController;
  }

  void showCustomDialog(BuildContext context, double credit) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Result",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(size * .02),
              child: Material(
                color: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size * .02)),
                child: Padding(
                  padding: EdgeInsets.all(size * .02),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: size * .08,
                        backgroundColor: credit > 1.9
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).errorColor,
                        child: IconButton(
                          onPressed: () {},
                          iconSize: size * .06,
                          icon: credit > 1.9
                              ? Icon(
                                  Icons.done,
                                  color: Theme.of(context).cardColor,
                                )
                              : Icon(
                                  Icons.error_rounded,
                                  color: Theme.of(context).cardColor,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: size * .03,
                      ),
                      Text(
                        "Credit score: ${credit.toStringAsFixed(2) }",
                        style: TextStyle(
                            fontSize: size * .02,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        height: size * .03,
                      ),
                      Flexible(
                        child: Text(
                          "NB : Please Make sure your credit score is >= 1.9",
                          style: TextStyle(
                              fontSize: size * .02,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            height: size * .05,
                            width: size * .15,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(size * .03)),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).primaryColorDark,
                                  ]),
                            ),
                            child: InkWell(
                              onTap: () {
                                credit >= 1.9 ? savePdf() : customPop();
                              },
                              child: Center(
                                child: Text(
                                  credit >= 1.9 ? "Save To PDF" : "Close",style: TextStyle(color: Theme.of(context).cardColor),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ));
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

  TableRow getTableRow(String title, String value) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.all(size * .01),
        child: Text(
          title,
          style: TextStyle(color: Theme.of(context).canvasColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(size * .01),
        child: Text(
          value,
          style: TextStyle(color: Theme.of(context).canvasColor),
        ),
      ),
    ]);
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        Helper.calculateCredit(widget.formController).then((value) {
          credit = value;
          showCustomDialog(context, value);
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: customPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back_ios, color: Theme.of(context).cardColor),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            },
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Image.asset('assets/img/logo.png'),
        ),
        body: credit >= 1.9
            ? SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(size * .015),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        children: [
                          getTableRow("Es Enrolment Id",
                              widget.formController.general.enrolmentId),
                          getTableRow("Builder name",
                              widget.formController.general.builderName),
                          getTableRow("Site", widget.formController.house.site),
                          getTableRow("Phase",
                              widget.formController.house.phase.toString()),
                          getTableRow("Lot",
                              widget.formController.house.lot.toString()),
                          getTableRow(
                              "Address", widget.formController.house.address),
                          getTableRow("City", widget.formController.house.city),
                          getTableRow("Postal code",
                              widget.formController.house.postalCode),
                          getTableRow("Attached/Detached/Murb",
                              widget.formController.house.att_det_murb),
                          getTableRow("Evaluator name",
                              widget.formController.general.evaluatorName),
                          getTableRow(
                              "Evaluator number",
                              widget.formController.general.evaluatorId
                                  .toString()),
                          getTableRow("Inspection date",
                              widget.formController.general.inspectionDate),
                          getTableRow("Site contact name",
                              widget.formController.general.siteContactName),
                          getTableRow("Site contact email",
                              widget.formController.general.siteContactEmail),
                          getTableRow("Site contact number",
                              widget.formController.general.siteContactNumber),
                        ],
                        border: TableBorder.all(),
                      ),
                      SizedBox(
                        height: size * .03,
                      ),
                      Text(
                        "To whom it may concern:\n\nPlease accept this form as written notice that the property listed has been blower door tested and the evaluation completed to the NRCan’s, “Energy Star for New Homes: Technical Specifications – Ontario” as deemed acceptable under Supplementary Standard SB-12 - 2.1.3.1. "
                        "Other Acceptable Compliance Methods."
                        "\nAt the time of inspection, the official ENERGY STAR® label and package for this home may not have been available.  The appropriate label will be forwarded to the builder.\n\nSincerely,",
                        style: TextStyle(color: Theme.of(context).canvasColor),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        widget.formController.general.evaluatorName,
                        style: TextStyle(color: Theme.of(context).canvasColor),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        "NRCan Certified Energy Evaluator ",
                        style: TextStyle(color: Theme.of(context).canvasColor),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        widget.formController.general.evaluatorId.toString(),
                        style: TextStyle(color: Theme.of(context).canvasColor),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: size * .03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Share.shareFiles([pdfFile.path],
                                  text: pdfFile.path);
                            },
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Icon(
                              Icons.share_outlined,
                              size: size * .03,
                            ),
                            padding: EdgeInsets.all(size * .02),
                            shape: const CircleBorder(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: size / 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: size * .08,
                        backgroundColor: Theme.of(context).errorColor,
                        child: IconButton(
                          onPressed: () {},
                          iconSize: size * .06,
                          icon: Icon(
                            Icons.error_rounded,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size * .03,
                      ),
                      Text(
                        "Please Make sure your credit score is >= 1.9\nYou Can edit your data from Local Forms Page ",
                        style: TextStyle(
                            fontSize: size * .02,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
