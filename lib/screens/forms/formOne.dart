import 'dart:ui';

import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/models/descriprion.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/widgets/dropDownCustom.dart';
import 'package:bkc_field_form/widgets/formRow.dart';
import 'package:bkc_field_form/widgets/radioGroupCustom.dart';
import 'package:flutter/material.dart';

import '../../utils/remoteConfig.dart';

class FormOne extends StatefulWidget {
  final FormController formController;

  const FormOne({
    Key? key,
    required this.formController,
  }) : super(key: key);

  @override
  FormOneState createState() => FormOneState();
}

class FormOneState extends State<FormOne> {
  final size = currentDevice.value.height;
  List getCeilingList = [];
  List getCathedralList = [];
  List getWallsAboveGradeList = [];
  List getExposedFloorList = [];
  List getFoundationWallList = [];
  List getUnheatedSlabList = [];

  InputDecoration commentDecoration(double size, String hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(
        top: size * .02,
        left: size * .03,
        right: size * .01,
        bottom: size * .08,
      ),
      hintText: hint,
      labelText: hint,
      alignLabelWithHint: true,
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

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        initList().then((value) {
          initializeFormOne();
        });
      });
    });

    super.initState();
  }

  Future<void> initList() async {
    getCeilingList = await widget.formController.getCeiling();
    getCathedralList = await widget.formController.getCathedralAndFlatRoof();
    getWallsAboveGradeList = await widget.formController.getWallsAboveGrade();
    getExposedFloorList = await widget.formController.getExposedFloor();
    getFoundationWallList = await widget.formController.getFoundationWall();
    getUnheatedSlabList = await widget.formController.getUnheatedSlab();
  }

  void initializeFormOne() {
    widget.formController.buildComponentOne.cbaBOPDescription =
        widget.formController.buildComponentOne.cbaBOPDescription.isEmpty
            ? getCeilingList.first.name
            : widget.formController.buildComponentOne.cbaBOPDescription;
    widget.formController.buildComponentOne.cbaBOPCredit =
        widget.formController.buildComponentOne.cbaBOPCredit.isEmpty
            ? getCeilingList.first.value
            : widget.formController.buildComponentOne.cbaBOPCredit;

    widget.formController.buildComponentOne.cfrBOPDescription =
        widget.formController.buildComponentOne.cfrBOPDescription.isEmpty
            ? getCathedralList.first.name
            : widget.formController.buildComponentOne.cfrBOPDescription;
    widget.formController.buildComponentOne.cfrBOPCredit =
        widget.formController.buildComponentOne.cfrBOPCredit.isEmpty
            ? getCathedralList.first.value
            : widget.formController.buildComponentOne.cfrBOPCredit;

    widget.formController.buildComponentOne.wagBOPDescription =
        widget.formController.buildComponentOne.wagBOPDescription.isEmpty
            ? getWallsAboveGradeList.first.name
            : widget.formController.buildComponentOne.wagBOPDescription;
    widget.formController.buildComponentOne.wagBOPCredit =
        widget.formController.buildComponentOne.wagBOPCredit.isEmpty
            ? getWallsAboveGradeList.first.value
            : widget.formController.buildComponentOne.wagBOPCredit;

    widget.formController.buildComponentOne.efBOPDescription =
        widget.formController.buildComponentOne.efBOPDescription.isEmpty
            ? getExposedFloorList.first.name
            : widget.formController.buildComponentOne.efBOPDescription;
    widget.formController.buildComponentOne.efBOPCredit =
        widget.formController.buildComponentOne.efBOPCredit.isEmpty
            ? getExposedFloorList.first.value
            : widget.formController.buildComponentOne.efBOPCredit;

    widget.formController.buildComponentOne.fwBOPDescription =
        widget.formController.buildComponentOne.fwBOPDescription.isEmpty
            ? getFoundationWallList.first.name
            : widget.formController.buildComponentOne.fwBOPDescription;
    widget.formController.buildComponentOne.fwBOPCredit =
        widget.formController.buildComponentOne.fwBOPCredit.isEmpty
            ? getFoundationWallList.first.value
            : widget.formController.buildComponentOne.fwBOPCredit;

    widget.formController.buildComponentOne.uhbBOPDescription =
        widget.formController.buildComponentOne.uhbBOPDescription.isEmpty
            ? getUnheatedSlabList.first.name
            : widget.formController.buildComponentOne.uhbBOPDescription;
    widget.formController.buildComponentOne.uhbBOPCredit =
        widget.formController.buildComponentOne.uhbBOPCredit.isEmpty
            ? getUnheatedSlabList.first.value
            : widget.formController.buildComponentOne.uhbBOPCredit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).cardColor,
        onRefresh: () {
          return RemoteConfigService.setupRemoteConfig(context).then((value) {
            setState(() {
              initList();
            });
          });
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size * .01,
              ),
              Text(
                "Building Insulation",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size * .03),
              ),
              getCeilingList.isNotEmpty
                  ? FormRow(
                      dropDownCallback: (description) {
                        widget.formController.buildComponentOne
                            .cbaBOPDescription = description.name;
                        widget.formController.buildComponentOne.cbaBOPCredit =
                            description.value;
                      },
                      dropDownInitial: widget.formController.buildComponentOne
                              .cbaBOPDescription.isEmpty
                          ? getCeilingList.first.name
                          : widget.formController.buildComponentOne
                              .cbaBOPDescription,
                      descriptionList: List.from(getCeilingList),
                      verificationList: widget.formController.getVerification(),
                      verifiedCallback: (verified) {
                        widget.formController.buildComponentOne
                            .cbaVerification = verified;
                      },
                      isModel: false,
                      isImage: false,
                      isMake: false,
                      verificationInitial: widget
                          .formController.buildComponentOne.cbaVerification,
                      title: "Ceilings\nBelow Attics",
                    )
                  : const SizedBox(),
              getCathedralList.isNotEmpty
                  ? FormRow(
                      dropDownCallback: (description) {
                        widget.formController.buildComponentOne
                            .cfrBOPDescription = description.name;
                        widget.formController.buildComponentOne.cfrBOPCredit =
                            description.value;
                      },
                      dropDownInitial: widget.formController.buildComponentOne
                              .cfrBOPDescription.isEmpty
                          ? getCathedralList.first.name
                          : widget.formController.buildComponentOne
                              .cfrBOPDescription,
                      descriptionList: List.from(getCathedralList),
                      verificationList: widget.formController.getVerification(),
                      verifiedCallback: (verified) {
                        widget.formController.buildComponentOne
                            .cfrVerification = verified;
                      },
                      isModel: false,
                      isImage: false,
                      isMake: false,
                      verificationInitial: widget
                          .formController.buildComponentOne.cfrVerification,
                      title: "Cathedral and\nFlat Roofs",
                    )
                  : const SizedBox(),
              getWallsAboveGradeList.isNotEmpty
                  ? FormRow(
                      dropDownCallback: (description) {
                        widget.formController.buildComponentOne
                            .wagBOPDescription = description.name;
                        widget.formController.buildComponentOne.wagBOPCredit =
                            description.value;
                      },
                      dropDownInitial: widget.formController.buildComponentOne
                              .wagBOPDescription.isEmpty
                          ? getWallsAboveGradeList.first.name
                          : widget.formController.buildComponentOne
                              .wagBOPDescription,
                      descriptionList: List.from(getWallsAboveGradeList),
                      verificationList: widget.formController.getVerification(),
                      verifiedCallback: (verified) {
                        widget.formController.buildComponentOne
                            .wagVerification = verified;
                      },
                      isModel: false,
                      isImage: false,
                      isMake: false,
                      verificationInitial: widget
                          .formController.buildComponentOne.wagVerification,
                      title: "Walls\nAbove Grade",
                    )
                  : const SizedBox(),
              getExposedFloorList.isNotEmpty? FormRow(
                dropDownCallback: (description) {
                  widget.formController.buildComponentOne.efBOPDescription =
                      description.name;
                  widget.formController.buildComponentOne.efBOPCredit =
                      description.value;
                },
                dropDownInitial: widget.formController.buildComponentOne
                        .efBOPDescription.isEmpty
                    ? getExposedFloorList.first.name
                    : widget.formController.buildComponentOne.efBOPDescription,
                descriptionList: List.from(getExposedFloorList),
                verificationList: widget.formController.getVerification(),
                verifiedCallback: (verified) {
                  widget.formController.buildComponentOne.efVerification =
                      verified;
                },
                isModel: false,
                isImage: false,
                isMake: false,
                verificationInitial:
                    widget.formController.buildComponentOne.efVerification,
                title: "Exposed\nFloors",
              ):const SizedBox(),
            getFoundationWallList.isNotEmpty? FormRow(
                dropDownCallback: (description) {
                  widget.formController.buildComponentOne.fwBOPDescription =
                      description.name;
                  widget.formController.buildComponentOne.fwBOPCredit =
                      description.value;
                },
                dropDownInitial: widget.formController.buildComponentOne
                        .fwBOPDescription.isEmpty
                    ? getFoundationWallList.first.name
                    : widget.formController.buildComponentOne.fwBOPDescription,
                descriptionList: List.from(getFoundationWallList),
                verificationList: widget.formController.getVerification(),
                verifiedCallback: (verified) {
                  widget.formController.buildComponentOne.fwVerification =
                      verified;
                },
                isModel: false,
                isImage: true,
                isMake: false,
                verificationInitial:
                    widget.formController.buildComponentOne.fwVerification,
                title: "Foundation\nWalls",
                imgCallback: (image) {
                  widget.formController.buildComponentOne.fwImage = image;
                },
                initialImage: widget.formController.buildComponentOne.fwImage,
              ):const SizedBox(),
              getUnheatedSlabList.isNotEmpty? FormRow(
                dropDownCallback: (description) {
                  widget.formController.buildComponentOne.uhbBOPDescription =
                      description.name;
                  widget.formController.buildComponentOne.uhbBOPCredit =
                      description.value;
                },
                dropDownInitial: widget.formController.buildComponentOne
                        .uhbBOPDescription.isEmpty
                    ? getUnheatedSlabList.first.name
                    : widget.formController.buildComponentOne.uhbBOPDescription,
                descriptionList: List.from(getUnheatedSlabList),
                verificationList: widget.formController.getVerification(),
                verifiedCallback: (verified) {
                  widget.formController.buildComponentOne.uhbVerification =
                      verified;
                },
                isModel: false,
                isImage: false,
                isMake: false,
                verificationInitial:
                    widget.formController.buildComponentOne.uhbVerification,
                title: "Unheated Basement\nslab below grade",
              ):const SizedBox(),
              SizedBox(
                height: size * .03,
              ),
              Padding(
                padding: EdgeInsets.all(size * .01),
                child: TextFormField(
                  style: const TextStyle(
                    color: Color(0xff128841),
                  ),
                  maxLines: null,
                  initialValue:
                      widget.formController.buildComponentOne.comments,
                  onChanged: (input) {
                    widget.formController.buildComponentOne.comments = input;
                  },
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.toString().isEmpty) {
                      return "Please enter a comment";
                    } else {
                      return null;
                    }
                  },
                  decoration: commentDecoration(size, "Comments"),
                ),
              ),
              SizedBox(
                height: size * .07,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
