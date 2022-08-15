import 'dart:io';

import 'package:bkc_field_form/controllers/document_controller.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/widgets/drawer.dart';
import 'package:bkc_field_form/widgets/dropDownCustom.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart' as mvc;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/pdf.dart';
import '../utils/helper.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({
    Key? key,
  }) : super(key: key);

  @override
  DocumentScreenState createState() => DocumentScreenState();
}

class DocumentScreenState extends mvc.StateMVC<DocumentScreen> {
  final height = currentDevice.value.height;
  Future<List<Pdf>>? documentList;
  final size = currentDevice.value.height;
  late DocumentController documentController;

  DocumentScreenState() : super(DocumentController()) {
    documentController = controller as DocumentController;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        drawer: DrawerWidget(
          height: height,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.03),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1)),
                padding: EdgeInsets.all(size * .01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: size * .02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              height: size * .05,
                              padding: EdgeInsets.all(size * .01),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size * .01),
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1)),
                              child: DropdownButton<String>(
                                  dropdownColor: Theme.of(context).cardColor,
                                  borderRadius:
                                      BorderRadius.circular(size * .01),
                                  menuMaxHeight: size * .3,
                                  hint: Text(
                                    "Select month",
                                    style: TextStyle(
                                        fontSize: size * .02,
                                        color: Theme.of(context).hintColor),
                                  ),
                                  value: documentController
                                          .selectedMonth.isNotEmpty
                                      ? documentController.selectedMonth
                                      : null,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  items: documentController.months
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  fontSize: size * .02,
                                                  color: Theme.of(context)
                                                      .canvasColor),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (item) => {
                                        setState(() {
                                          documentController.selectedMonth =
                                              item!;
                                        })
                                      }),
                            );
                          }),
                        ),
                        SizedBox(
                          width: size * .02,
                        ),
                        Expanded(
                          flex: 1,
                          child: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              height: size * .05,
                              padding: EdgeInsets.all(size * .01),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size * .01),
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1)),
                              child: DropdownButton<String>(
                                  dropdownColor: Theme.of(context).cardColor,
                                  borderRadius:
                                      BorderRadius.circular(size * .01),
                                  hint: Text(
                                    "Select year",
                                    style: TextStyle(
                                        fontSize: size * .02,
                                        color: Theme.of(context).hintColor),
                                  ),
                                  menuMaxHeight: size * .3,
                                  value:
                                      documentController.selectedYear.isNotEmpty
                                          ? documentController.selectedYear
                                          : null,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  items: documentController.year
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  fontSize: size * .02,
                                                  color: Theme.of(context)
                                                      .canvasColor),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (item) => {
                                        setState(() {
                                          documentController.selectedYear =
                                              item!;
                                        })
                                      }),
                            );
                          }),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size * .01,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size * .01,
              ),
              Padding(
                padding: EdgeInsets.only(right: size * .01),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: size * .05,
                    width: size * .15,
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
                        onPressed: () async {
                          if (documentController.selectedYear.isEmpty ||
                              documentController.selectedMonth.isEmpty) {
                            documentController.showSnackBar(
                                context, "Please select month and year");
                          } else {
                            /*final dir = Directory((Platform.isAndroid
                                    ? await getExternalStorageDirectory()
                                    : await getApplicationSupportDirectory())!
                                .path);

                            dir.deleteSync(recursive: true);*/
                            documentList =
                                documentController.fileLists(context);
                            setState(() {});
                          }
                        },
                        child: Text(
                          'Search',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme.of(context).cardColor),
                        )),
                  ),
                ),
              ),
              documentList == null
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(top: size * .02),
                      child: FutureBuilder<List<Pdf>>(
                          future: documentList,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (documentController.allContents == null ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                documentController.allContents!.isNotEmpty) {
                              return ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    documentController.allContents!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/pdfViewer',
                                          arguments: File(documentController
                                              .allContents![index].path));
                                    },
                                    child: Container(
                                      color: Theme.of(context).primaryColor.withOpacity(.4),
                                      margin: EdgeInsets.symmetric(horizontal: 0,vertical: height * .001),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: size * .01,
                                            right: size * .01),
                                        child: Row(
                                         
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "PDF " +
                                                    documentController
                                                        .allContents![index].id +
                                                    " " +
                                                    documentController
                                                        .allContents![index].site,
                                                style: TextStyle(
                                                    fontSize: size * .02,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                documentController
                                                    .allContents![index].date,
                                                style: TextStyle(
                                                    fontSize: size * .02,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(size * .01),
                                              child: IconButton(
                                                icon: Icon(Icons.share,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                onPressed: () {
                                                  Share.shareFiles([
                                                    documentController
                                                        .allContents![index]
                                                        .path
                                                  ],
                                                      text: documentController
                                                          .allContents![index]
                                                          .path);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                scrollDirection: Axis.vertical,
                              );
                            } else {
                              return SizedBox(
                                height: size / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Couldn't find any documents",
                                      style: TextStyle(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.document_scanner,
                                          color: Theme.of(context).hintColor),
                                      iconSize: size * .1,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox();
                          }),
                    ),
            ],
          ),
        ));
  }
}
