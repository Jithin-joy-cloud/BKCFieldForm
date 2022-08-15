import 'dart:convert';
import 'package:bkc_field_form/models/completeForm.dart';
import 'package:flutter/material.dart';
import '../models/device.dart';
import '../utils/style.dart';

class FormDetail extends StatefulWidget {
  final CompleteForm form;

  const FormDetail({Key? key, required this.form}) : super(key: key);

  @override
  FormDetailState createState() => FormDetailState();
}

class FormDetailState extends State<FormDetail> with TickerProviderStateMixin {
  final height = currentDevice.value.height;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this,
    );
    _tabController.animateTo(2, curve: Curves.bounceOut);
  }

  static const List<Tab> _tabs = [
    Tab(child: Text('General')),
    Tab(text: 'House'),
    Tab(text: 'Building Insulation'),
    Tab(text: 'Windows & Door'),
    Tab(text: 'Air Tightness'),
  ];
  late final List<Widget> _views = [
    GetGeneral(
      form: widget.form,
      height: height,
    ),
    GetHouse(
      form: widget.form,
      height: height,
    ),
    BuildingComponentOne(
      form: widget.form,
      height: height,
    ),
    BuildingComponentTwo(
      form: widget.form,
      height: height,
    ),
    BuildingComponentThree(
      form: widget.form,
      height: height,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Style.themeData(false, context),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 5,
            child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Theme.of(context).cardColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  bottom: TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Theme.of(context).cardColor,
                    indicatorPadding: EdgeInsets.all(height * .01),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),

                    indicatorColor: Theme.of(context).cardColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor),
                    isScrollable: true,
                    physics: const BouncingScrollPhysics(),
                    onTap: (int index) {},

                    // controller: _tabController,
                    tabs: _tabs,
                  ),
                  centerTitle: true,
                  backgroundColor: Theme.of(context).primaryColorDark,
                  title: Image.asset('assets/img/logo.png'),
                ),
                body: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  // controller: _tabController,
                  children: _views,
                ))));
  }
}

class GetGeneral extends StatelessWidget {
  final CompleteForm form;
  final double height;

  const GetGeneral({
    Key? key,
    required this.form,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Enrolment ID : " + form.general.target!.enrolmentId,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Alternative File ID : " + form.general.target!.alt_file_id,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "CHBA NZ File #:  " + form.general.target!.chba_nz_file,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Prescriptive or Performance: " +
                      form.general.target!.perspective,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "SO Name and #:  " + form.general.target!.soName,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "HDD Zone : " + form.general.target!.hddZone,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Builder Name: " + form.general.target!.builderName,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .02),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Builder ID: ${ form.general.target!.builderId.toString() ==
                      "null"
                      ? ""
                      : form.general.target!.builderId.toString()}" ,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Evaluator Name: " + form.general.target!.evaluatorName,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Evaluator Number: " +
                      form.general.target!.evaluatorId.toString(),
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Field Technician: " + form.general.target!.fieldTechnician,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Inspection Date: " + form.general.target!.inspectionDate,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Site Contact Name: " + form.general.target!.siteContactName,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Site Contact Email: " +
                      form.general.target!.siteContactEmail,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Site Contact phone Number: " +
                      form.general.target!.siteContactNumber,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
        ],
      ),
    );
  }
}

class GetHouse extends StatelessWidget {
  final CompleteForm form;
  final double height;

  const GetHouse({Key? key, required this.form, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Site: " + form.house.target!.site,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Phase: " + form.house.target!.phase.toString(),
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Lot:  " + form.house.target!.lot.toString(),
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Address: " + form.house.target!.address,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "City:  " + form.house.target!.city,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Postal Code: " + form.house.target!.postalCode,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Province: " + form.house.target!.province,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Att./Detached/Murb: " + form.house.target!.att_det_murb,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Mid/End: " + form.house.target!.mid_end_,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Direction: " + form.house.target!.direction,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Special Condition: " + form.house.target!.specialCondition,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Model Name: " + form.house.target!.modelName,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Volume: " + form.house.target!.volume.toString(),
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Text(
                  "Surface Area: " + form.house.target!.surfaceArea.toString(),
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: height * .022),
                ),
              )),
        ],
      ),
    );
  }
}

class BuildingComponentOne extends StatelessWidget {
  final CompleteForm form;
  final double height;

  const BuildingComponentOne(
      {Key? key, required this.form, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Ceilings Below Attics",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentOne.target!
                                      .cbaVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Bop : " +
                                  form.buildComponentOne.target!
                                      .cbaBOPDescription,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                          SizedBox(
                            width: height * .01,
                          ),
                          Flexible(
                            child: Text(
                              "credit : " +
                                  form.buildComponentOne.target!.cbaBOPCredit,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Cathedral and Flat Roofs",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentOne.target!
                                      .cfrVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Bop : " +
                                  form.buildComponentOne.target!
                                      .cfrBOPDescription,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                          SizedBox(
                            width: height * .01,
                          ),
                          Flexible(
                            child: Text(
                              "credit : " +
                                  form.buildComponentOne.target!.cfrBOPCredit,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Walls Above Grade",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentOne.target!
                                      .wagVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Bop : " +
                                  form.buildComponentOne.target!
                                      .wagBOPDescription,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                          SizedBox(
                            width: height * .01,
                          ),
                          Flexible(
                            child: Text(
                              "credit : " +
                                  form.buildComponentOne.target!.wagBOPCredit,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Exposed Floors",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentOne.target!.efVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Bop : " +
                                  form.buildComponentOne.target!
                                      .efBOPDescription,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                          SizedBox(
                            width: height * .01,
                          ),
                          Flexible(
                            child: Text(
                              "credit : " +
                                  form.buildComponentOne.target!.efBOPCredit,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Foundation Walls",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * .02),
                                  ),
                                ),
                                Text(
                                  "verification: " +
                                      form.buildComponentOne.target!
                                          .fwVerification,
                                  style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: height * .02),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Bop : " +
                                        form.buildComponentOne.target!
                                            .fwBOPDescription,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                                SizedBox(
                                  width: height * .01,
                                ),
                                Text(
                                  "credit : " +
                                      form.buildComponentOne.target!
                                          .fwBOPCredit,
                                  style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: height * .02),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    form.buildComponentOne.target!.fwImage.isEmpty
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.image),
                            iconSize: height * .08,
                            color: Theme.of(context).primaryColor,
                          )
                        : InkWell(
                            onTap: () {
                              showCustomDialog(
                                  context,
                                  form.buildComponentOne.target!.fwImage,
                                  height);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(height * .01),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(height * .1),
                                child: Image.memory(
                                  base64Decode(
                                      form.buildComponentOne.target!.fwImage),
                                  width: height * .08,
                                  height: height * .08,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Unheated Basement slab below grade",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentOne.target!
                                      .uhbVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Bop : " +
                                  form.buildComponentOne.target!
                                      .uhbBOPDescription,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                          SizedBox(
                            width: height * .01,
                          ),
                          Flexible(
                            child: Text(
                              "credit : " +
                                  form.buildComponentOne.target!.uhbBOPCredit,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Comments ",
                      style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontWeight: FontWeight.bold,
                          fontSize: height * .02),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Text(
                        form.buildComponentOne.target!.comments.isNotEmpty
                            ? form.buildComponentOne.target!.comments
                            : "N/A",
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontSize: height * .02),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class BuildingComponentTwo extends StatelessWidget {
  final CompleteForm form;
  final double height;

  const BuildingComponentTwo(
      {Key? key, required this.form, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Windows",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * .02),
                                  ),
                                ),
                                Text(
                                  "verification: " +
                                      form.buildComponentTwo.target!
                                          .windowVerification,
                                  style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: height * .02),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Bop : " +
                                        form.buildComponentTwo.target!
                                            .windowBOPDescription,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                                SizedBox(
                                  width: height * .01,
                                ),
                                Flexible(
                                  child: Text(
                                    "credit : " +
                                        form.buildComponentTwo.target!
                                            .windowBOPCredit,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                form.buildComponentTwo.target!.windowMake
                                        .isNotEmpty
                                    ? "make: ${form.buildComponentTwo.target!.windowMake}"
                                    : "make: N/A",
                                style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontSize: height * .02),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    form.buildComponentTwo.target!.windowImage.isEmpty
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.image),
                            iconSize: height * .08,
                            color: Theme.of(context).primaryColor,
                          )
                        : InkWell(
                            onTap: () {
                              showCustomDialog(
                                  context,
                                  form.buildComponentTwo.target!.windowImage,
                                  height);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(height * .01),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(height * .1),
                                child: Image.memory(
                                  base64Decode(form
                                      .buildComponentTwo.target!.windowImage),
                                  width: height * .08,
                                  height: height * .08,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Triples",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentTwo.target!
                                      .triplesVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Bop : ${form.buildComponentTwo.target!.triplesBOPDescription.isNotEmpty ? form.buildComponentTwo.target!.triplesBOPDescription : "N/A"}",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Insulated Door",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentTwo.target!
                                      .insulatedDoorVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Insulated Door availability : ${form.buildComponentTwo.target!.insulatedDoorRequired}",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Cellar Door",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentTwo.target!
                                      .cellarDoorVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Cellar Door availability : ${form.buildComponentTwo.target!.cellarDoorRequired}",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Solar PV",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentTwo.target!
                                      .solarPVVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Solar PV availability : ${form.buildComponentTwo.target!.solarPVRequired}",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Energy Monitor",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentTwo.target!
                                      .energyMonitorVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Energy Monitor availability : ${form.buildComponentTwo.target!.energyMonitorRequired}",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Fireplace",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * .02),
                                  ),
                                ),
                                Text(
                                  "verification: " +
                                      form.buildComponentTwo.target!
                                          .fireplaceVerification,
                                  style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: height * .02),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Bop : " +
                                        form.buildComponentTwo.target!
                                            .fireplaceBOPDescription,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                                SizedBox(
                                  width: height * .01,
                                ),
                                Flexible(
                                  child: Text(
                                    "credit : " +
                                        form.buildComponentTwo.target!
                                            .fireplaceCredit,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    form.buildComponentTwo.target!.fireplaceMake
                                            .isNotEmpty
                                        ? "make: ${form.buildComponentTwo.target!.fireplaceMake}"
                                        : "make: N/A",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    form.buildComponentTwo.target!
                                            .fireplaceModel.isNotEmpty
                                        ? "Model: ${form.buildComponentTwo.target!.fireplaceModel}"
                                        : "Model: N/A",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    form.buildComponentTwo.target!.fireplaceImage.isEmpty
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.image),
                            iconSize: height * .08,
                            color: Theme.of(context).primaryColor,
                          )
                        : InkWell(
                            onTap: () {
                              showCustomDialog(
                                  context,
                                  form.buildComponentTwo.target!.fireplaceImage,
                                  height);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(height * .01),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(height * .1),
                                child: Image.memory(
                                  base64Decode(form.buildComponentTwo.target!
                                      .fireplaceImage),
                                  width: height * .08,
                                  height: height * .08,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Electrical Savings",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentTwo.target!.esVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Bop : " +
                                  form.buildComponentTwo.target!
                                      .esBOPDescription,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                          SizedBox(
                            width: height * .01,
                          ),
                          Flexible(
                            child: Text(
                              "credit : " +
                                  form.buildComponentTwo.target!.esBOPCredit,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Comments ",
                      style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontWeight: FontWeight.bold,
                          fontSize: height * .02),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Text(
                        form.buildComponentTwo.target!.comments.isNotEmpty
                            ? form.buildComponentTwo.target!.comments
                            : "N/A",
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontSize: height * .02),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class BuildingComponentThree extends StatelessWidget {
  final CompleteForm form;
  final double height;

  const BuildingComponentThree(
      {Key? key, required this.form, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Space Heating",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * .02),
                                  ),
                                ),
                                Text(
                                  "verification: " +
                                      form.buildComponentThree.target!
                                          .spaceHeatingVerification,
                                  style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: height * .02),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Bop : " +
                                        form.buildComponentThree.target!
                                            .spaceHeatingBOPDescription,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                                SizedBox(
                                  width: height * .01,
                                ),
                                Flexible(
                                  child: Text(
                                    "credit : " +
                                        form.buildComponentThree.target!
                                            .spaceHeatingCredit,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(height * .006),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    form.buildComponentThree.target!
                                            .spaceHeatingMake.isNotEmpty
                                        ? "make: ${form.buildComponentThree.target!.spaceHeatingMake}"
                                        : "make: N/A",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(height * .006),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    form.buildComponentThree.target!
                                            .spaceHeatingModel.isNotEmpty
                                        ? "Model: ${form.buildComponentThree.target!.spaceHeatingModel}"
                                        : "Model: N/A",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    form.buildComponentThree.target!.spaceHeatingImage.isEmpty
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.image),
                            iconSize: height * .08,
                            color: Theme.of(context).primaryColor,
                          )
                        : InkWell(
                            onTap: () {
                              showCustomDialog(
                                  context,
                                  form.buildComponentThree.target!
                                      .spaceHeatingImage,
                                  height);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(height * .01),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(height * .1),
                                child: Image.memory(
                                  base64Decode(form.buildComponentThree.target!
                                      .spaceHeatingImage),
                                  width: height * .08,
                                  height: height * .08,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Space Cooling",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * .02),
                                  ),
                                ),
                                Text(
                                  "verification: " +
                                      form.buildComponentThree.target!
                                          .spaceCoolingVerification,
                                  style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: height * .02),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Bop : " +
                                        form.buildComponentThree.target!
                                            .spaceCoolingBOPDescription,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                                SizedBox(
                                  width: height * .01,
                                ),
                                Flexible(
                                  child: Text(
                                    "credit : " +
                                        form.buildComponentThree.target!
                                            .spaceCoolingCredit,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(height * .006),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    form.buildComponentThree.target!
                                            .spaceCoolingMake.isNotEmpty
                                        ? "make: ${form.buildComponentThree.target!.spaceCoolingMake}"
                                        : "make: N/A",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(height * .006),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    form.buildComponentThree.target!
                                            .spaceCoolingModel.isNotEmpty
                                        ? "Model: ${form.buildComponentThree.target!.spaceCoolingModel}"
                                        : "Model: N/A",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    form.buildComponentThree.target!.spaceCoolingImage.isEmpty
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.image),
                            iconSize: height * .08,
                            color: Theme.of(context).primaryColor,
                          )
                        : InkWell(
                            onTap: () {
                              showCustomDialog(
                                  context,
                                  form.buildComponentThree.target!
                                      .spaceCoolingImage,
                                  height);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(height * .01),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(height * .1),
                                child: Image.memory(
                                  base64Decode(form.buildComponentThree.target!
                                      .spaceCoolingImage),
                                  width: height * .08,
                                  height: height * .08,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Duct Sealing",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * .02),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "verification: " +
                                        form.buildComponentThree.target!
                                            .ductSealingVerification,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Duct Sealing Availability : " +
                                        form.buildComponentThree.target!
                                            .ductSealingRequired,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Domestic Hot Water",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * .02),
                                  ),
                                ),
                                Text(
                                  "verification: " +
                                      form.buildComponentThree.target!
                                          .domesticHotWaterVerification,
                                  style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: height * .02),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Bop : " +
                                        form.buildComponentThree.target!
                                            .domesticHotWaterBOPDescription,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                                SizedBox(
                                  width: height * .01,
                                ),
                                Flexible(
                                  child: Text(
                                    "credit : " +
                                        form.buildComponentThree.target!
                                            .domesticHotWaterCredit,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(height * .006),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      form.buildComponentThree.target!
                                              .domesticHotWaterMake.isNotEmpty
                                          ? "make: ${form.buildComponentThree.target!.domesticHotWaterMake}"
                                          : "make: N/A",
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: height * .02),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(height * .006),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      form.buildComponentThree.target!
                                              .domesticHotWaterModel.isNotEmpty
                                          ? "Model: ${form.buildComponentThree.target!.domesticHotWaterModel}"
                                          : "Model: N/A",
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: height * .02),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    form.buildComponentThree.target!.domesticHotWaterImage
                            .isEmpty
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.image),
                            iconSize: height * .08,
                            color: Theme.of(context).primaryColor,
                          )
                        : InkWell(
                            onTap: () {
                              showCustomDialog(
                                  context,
                                  form.buildComponentThree.target!
                                      .domesticHotWaterImage,
                                  height);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(height * .01),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(height * .1),
                                child: Image.memory(
                                  base64Decode(form.buildComponentThree.target!
                                      .domesticHotWaterImage),
                                  width: height * .08,
                                  height: height * .08,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Drain Water Heat Recovery",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * .02),
                                  ),
                                ),
                                Text(
                                  "verification: " +
                                      form.buildComponentThree.target!
                                          .drainWaterVerification,
                                  style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: height * .02),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Bop : " +
                                        form.buildComponentThree.target!
                                            .drainWaterBOPDescription,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                ),
                                SizedBox(
                                  width: height * .01,
                                ),
                                Flexible(
                                  child: Text(
                                    "credit : " +
                                        form.buildComponentThree.target!
                                            .drainWaterCredit,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: height * .02),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .015,
                            color: Theme.of(context).cardColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(height * .006),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      form.buildComponentThree.target!
                                              .drainWaterMake.isNotEmpty
                                          ? "make: ${form.buildComponentThree.target!.drainWaterMake}"
                                          : "make: N/A",
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: height * .02),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(height * .006),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      form.buildComponentThree.target!
                                              .drainWaterModel.isNotEmpty
                                          ? "Model: ${form.buildComponentThree.target!.drainWaterModel}"
                                          : "Model: N/A",
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: height * .02),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    form.buildComponentThree.target!.drainWaterImage.isEmpty
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.image),
                            iconSize: height * .08,
                            color: Theme.of(context).primaryColor,
                          )
                        : InkWell(
                            onTap: () {
                              showCustomDialog(
                                  context,
                                  form.buildComponentThree.target!
                                      .drainWaterImage,
                                  height);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(height * .01),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(height * .1),
                                child: Image.memory(
                                  base64Decode(form.buildComponentThree.target!
                                      .drainWaterImage),
                                  width: height * .08,
                                  height: height * .08,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Air tightness",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .02),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "verification: " +
                                  form.buildComponentThree.target!
                                      .airTightnessVerification,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Bop : " +
                                  form.buildComponentThree.target!
                                      .airTightnessBOPDescription,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                          SizedBox(
                            width: height * .01,
                          ),
                          Flexible(
                            child: Text(
                              "credit : " +
                                  form.buildComponentThree.target!
                                      .airTightnessCredit,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(height * .006),
                          child: Text(
                            form.buildComponentThree.target!.airTightnessACH
                                    .isNotEmpty
                                ? "ACH: ${form.buildComponentThree.target!.airTightnessACH}"
                                : "ACH: N/A",
                            style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontSize: height * .02),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(height * .006),
                          child: Text(
                            form.buildComponentThree.target!.airTightnessNLR
                                    .isNotEmpty
                                ? "NLR: ${form.buildComponentThree.target!.airTightnessNLR}"
                                : "NLR: N/A",
                            style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontSize: height * .02),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(height * .006),
                          child: Text(
                            form.buildComponentThree.target!.airTightnessEQLA
                                    .isNotEmpty
                                ? "EQLA: ${form.buildComponentThree.target!.airTightnessEQLA}"
                                : "EQLA: N/A",
                            style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontSize: height * .02),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(height * .006),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Ventilation (HRV / ERV)",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).canvasColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: height * .02),
                                      ),
                                    ),
                                    Text(
                                      "verification: " +
                                          form.buildComponentThree.target!
                                              .ventilationVerification,
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: height * .02),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: height * .015,
                                color: Theme.of(context).cardColor,
                              ),
                              Padding(
                                padding: EdgeInsets.all(height * .006),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Bop : " +
                                            form.buildComponentThree.target!
                                                .ventilationBOPDescription,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).canvasColor,
                                            fontSize: height * .02),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "credit : " +
                                            form.buildComponentThree.target!
                                                .ventilationCredit,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).canvasColor,
                                            fontSize: height * .02),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: height * .015,
                                color: Theme.of(context).cardColor,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(height * .006),
                                          child: Text(
                                            form.buildComponentThree.target!
                                                    .ventilationMake.isNotEmpty
                                                ? "Make: ${form.buildComponentThree.target!.ventilationMake}"
                                                : "Make: N/A",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                fontSize: height * .02),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(height * .006),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              form
                                                      .buildComponentThree
                                                      .target!
                                                      .ventilationModel
                                                      .isNotEmpty
                                                  ? "Model: ${form.buildComponentThree.target!.ventilationModel}"
                                                  : "Model: N/A",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  fontSize: height * .02),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: height * .015,
                                    color: Theme.of(context).cardColor,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(height * .006),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            form.buildComponentThree.target!
                                                    .ventilationFresh.isNotEmpty
                                                ? "Fresh: ${form.buildComponentThree.target!.ventilationFresh}"
                                                : "Fresh: N/A",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                fontSize: height * .02),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(height * .006),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            form.buildComponentThree.target!
                                                    .ventilationStale.isNotEmpty
                                                ? "Stale: ${form.buildComponentThree.target!.ventilationStale}"
                                                : "Stale: N/A",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                fontSize: height * .02),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        form.buildComponentThree.target!.ventilationImage
                                .isEmpty
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.image),
                                iconSize: height * .08,
                                color: Theme.of(context).primaryColor,
                              )
                            : InkWell(
                                onTap: () {
                                  showCustomDialog(
                                      context,
                                      form.buildComponentThree.target!
                                          .ventilationImage,
                                      height);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(height * .01),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(height * .1),
                                    child: Image.memory(
                                      base64Decode(form.buildComponentThree
                                          .target!.ventilationImage),
                                      width: height * .08,
                                      height: height * .08,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(height * .006),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Bedroom Count: ${form.buildComponentThree.target!.bedroomCount}",
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: height * .02),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "HRV Balanced Availability: ${form.buildComponentThree.target!.hrvBalanced}",
                                style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontSize: height * .02),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(height * .006),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Furnace fan Availability: ${form.buildComponentThree.target!.furnaceFan}",
                                style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontSize: height * .02),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: height * .001),
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(height * .02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Comments ",
                      style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontWeight: FontWeight.bold,
                          fontSize: height * .02),
                    ),
                    Divider(
                      height: height * .015,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: EdgeInsets.all(height * .006),
                      child: Text(
                        form.buildComponentThree.target!.comments.isNotEmpty
                            ? form.buildComponentThree.target!.comments
                            : "N/A",
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontSize: height * .02),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

void showCustomDialog(BuildContext context, String path, double height) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Result",
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
                child: FadeInImage(
                  placeholder: const AssetImage(
                    'assets/img/logo_progress.png',
                  ),
                  alignment: Alignment.center,
                  fadeInCurve: Curves.easeIn,
                  image: MemoryImage(
                    base64Decode(path),
                  ),
                  fit: BoxFit.cover,
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
