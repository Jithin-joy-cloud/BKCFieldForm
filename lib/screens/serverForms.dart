import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/main.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/widgets/alertDialogue.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/completeForm.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:bkc_field_form/repository/form_repositary.dart' as repository;

class ServerScreen extends StatefulWidget {
  const ServerScreen({
    Key? key,
  }) : super(key: key);

  @override
  ServerScreenState createState() => ServerScreenState();
}

class ServerScreenState extends StateMVC<ServerScreen> {
  final height = currentDevice.value.height;
  late FormController formController;
  late Future<List<CompleteForm>> futureForm;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ServerScreenState() : super(FormController()) {
    formController = controller as FormController;
  }

  @override
  void initState() {
    futureForm = formController.getForm(context);
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
        body: FutureBuilder<List<CompleteForm>>(
            future: futureForm,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final forms = snapshot.data;
                return ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: forms!.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return InkWell(onTap: (){
                      Navigator.pushNamed(context, '/formDetail',
                          arguments: forms[index]);
                    },
                      child: Container(
                        color: Theme.of(context).primaryColor.withOpacity(.4),
                        margin: EdgeInsets.symmetric(horizontal: 0,vertical: height * .001),
                        child: Padding(
                          padding: EdgeInsets.all(height * .02),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Inspection date: ${forms[index].general.target!.inspectionDate.toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Text(
                                  "Evaluator name: ${forms[index].general.target!.evaluatorName.toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Text(
                                  "Site name: ${forms[index].house.target!.site.toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.vertical,
                  /*  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: .1,
                    );
                  },*/
                );
              } else {
                return SizedBox(
                  height: height / 2,
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
                          iconSize: height * .1,
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
