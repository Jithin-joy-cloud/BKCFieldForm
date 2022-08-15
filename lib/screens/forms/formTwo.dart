import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/widgets/dropDownCustom.dart';
import 'package:bkc_field_form/widgets/formRow.dart';
import 'package:bkc_field_form/widgets/radioGroupCustom.dart';
import 'package:flutter/material.dart';

import '../../utils/remoteConfig.dart';

class FormTwo extends StatefulWidget {
  final FormController formController;

  const FormTwo({
    Key? key,
    required this.formController,
  }) : super(key: key);

  @override
  FormTwoState createState() => FormTwoState();
}

class FormTwoState extends State<FormTwo> {
  final size = currentDevice.value.height;
  List getWindowList = [];
  List getFirePlaceList = [];
  List getElectricalList = [];

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
          initializeFormTwo();
        });
      });
    });
    super.initState();
  }

  Future<void> initList() async {
    getWindowList = await widget.formController.getWindows();
    getFirePlaceList = await widget.formController.getFireplace();
    getElectricalList = await widget.formController.getElectricalSaving();
  }

  void initializeFormTwo() {
    widget.formController.buildComponentTwo.windowBOPDescription =
        widget.formController.buildComponentTwo.windowBOPDescription.isEmpty
            ? getWindowList.first.name
            : widget.formController.buildComponentTwo.windowBOPDescription;
    widget.formController.buildComponentTwo.windowBOPCredit =
        widget.formController.buildComponentTwo.windowBOPCredit.isEmpty
            ? getWindowList.first.value
            : widget.formController.buildComponentTwo.windowBOPCredit;

    widget.formController.buildComponentTwo.fireplaceBOPDescription =
        widget.formController.buildComponentTwo.fireplaceBOPDescription.isEmpty
            ? getFirePlaceList.first.name
            : widget.formController.buildComponentTwo.fireplaceBOPDescription;
    widget.formController.buildComponentTwo.fireplaceCredit =
        widget.formController.buildComponentTwo.fireplaceCredit.isEmpty
            ? getFirePlaceList.first.value
            : widget.formController.buildComponentTwo.fireplaceCredit;

    widget.formController.buildComponentTwo.esBOPDescription =
        widget.formController.buildComponentTwo.esBOPDescription.isEmpty
            ? getElectricalList.first.name
            : widget.formController.buildComponentTwo.esBOPDescription;
    widget.formController.buildComponentTwo.esBOPCredit =
        widget.formController.buildComponentTwo.esBOPCredit.isEmpty
            ? getElectricalList.first.value
            : widget.formController.buildComponentTwo.esBOPCredit;

    widget.formController.buildComponentTwo.insulatedDoorRequired.isEmpty
        ? widget.formController.buildComponentTwo.insulatedDoorRequired = "No"
        : widget.formController.buildComponentTwo.insulatedDoorRequired;

    widget.formController.buildComponentTwo.cellarDoorRequired.isEmpty
        ? widget.formController.buildComponentTwo.cellarDoorRequired = "No"
        : widget.formController.buildComponentTwo.cellarDoorRequired;

    widget.formController.buildComponentTwo.solarPVRequired.isEmpty
        ? widget.formController.buildComponentTwo.solarPVRequired = "No"
        : widget.formController.buildComponentTwo.solarPVRequired;

    widget.formController.buildComponentTwo.energyMonitorRequired.isEmpty
        ? widget.formController.buildComponentTwo.energyMonitorRequired = "No"
        : widget.formController.buildComponentTwo.energyMonitorRequired;
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
                "Widows And Doors",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size * .03),
              ),
              getWindowList.isNotEmpty
                  ? FormRow(
                      dropDownCallback: (description) {
                        widget.formController.buildComponentTwo
                            .windowBOPDescription = description.name;
                        widget.formController.buildComponentTwo
                            .windowBOPCredit = description.value;
                      },
                      dropDownInitial: widget.formController.buildComponentTwo
                              .windowBOPDescription.isEmpty
                          ? getWindowList.first.name
                          : widget.formController.buildComponentTwo
                              .windowBOPDescription,
                      descriptionList: List.from(getWindowList),
                      verificationList: widget.formController.getVerification(),
                      verifiedCallback: (verified) {
                        widget.formController.buildComponentTwo
                            .windowVerification = verified;
                      },
                      isModel: false,
                      isImage: true,
                      isMake: true,
                      verificationInitial: widget
                          .formController.buildComponentTwo.windowVerification,
                      title: "Windows",
                      imgCallback: (image) {
                        widget.formController.buildComponentTwo.windowImage =
                            image;
                      },
                      makeCallback: (make) {
                        widget.formController.buildComponentTwo.windowMake =
                            make;
                      },makeInitial: widget.formController.buildComponentTwo.windowMake,
                      initialImage:
                          widget.formController.buildComponentTwo.windowImage,
                    )
                  : const SizedBox(),
              SizedBox(
                height: size * .01,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size * .02, vertical: size * .01),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size * .2,
                            child: Text(
                              "Triples",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: size * .02),
                            ),
                          ),
                          RadioGroupCustom(
                            isBG: false,
                            list: widget.formController.getVerification(),
                            callback: (value) {
                              widget.formController.buildComponentTwo
                                  .triplesVerification = value;
                            },
                            selectedItem: widget.formController
                                .buildComponentTwo.triplesVerification,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.1),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 0)),
                    child: Padding(
                        padding: EdgeInsets.all(size * .015),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: size * .3,
                            child: TextFormField(
                              style: const TextStyle(color: Color(0xff128841)),
                              initialValue: widget.formController
                                  .buildComponentTwo.triplesBOPDescription,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLength: 15,
                              onChanged: (input) {
                                widget.formController.buildComponentTwo
                                    .triplesBOPDescription = input;
                              },
                              validator: (value) {
                                if (value!.toString().isEmpty) {
                                  return "Please enter a triple";
                                } else {
                                  return null;
                                }
                              },
                              decoration: showDecoration(size, "Triple"),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size * .02, vertical: size * .01),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size * .2,
                            child: Text(
                              "Insulated Door",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: size * .02),
                            ),
                          ),
                          RadioGroupCustom(
                            isBG: false,
                            list: widget.formController.getVerification(),
                            callback: (value) {
                              widget.formController.buildComponentTwo
                                  .insulatedDoorVerification = value;
                            },
                            selectedItem: widget.formController
                                .buildComponentTwo.insulatedDoorVerification,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.1),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 0)),
                    child: Padding(
                      padding: EdgeInsets.all(size * .01),
                      child: RadioGroupCustom(
                        isBG: false,
                        list: const [
                          "No",
                          "Yes",
                        ],
                        callback: (value) {
                          widget.formController.buildComponentTwo
                              .insulatedDoorRequired = value;
                        },
                        selectedItem: widget.formController.buildComponentTwo
                            .insulatedDoorRequired,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size * .01,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size * .02, vertical: size * .01),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size * .2,
                            child: Text(
                              "Cold cellar Door",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: size * .02),
                            ),
                          ),
                          RadioGroupCustom(
                            isBG: false,
                            list: widget.formController.getVerification(),
                            callback: (value) {
                              widget.formController.buildComponentTwo
                                  .cellarDoorVerification = value;
                            },
                            selectedItem: widget.formController
                                .buildComponentTwo.cellarDoorVerification,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.1),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 0)),
                    child: Padding(
                      padding: EdgeInsets.all(size * .01),
                      child: RadioGroupCustom(
                        isBG: false,
                        list: const [
                          "No",
                          "Yes",
                        ],
                        callback: (value) {
                          widget.formController.buildComponentTwo
                              .cellarDoorRequired = value;
                        },
                        selectedItem: widget.formController.buildComponentTwo
                            .cellarDoorRequired,
                      ),
                    ),
                  ),
                ],
              ),
              getFirePlaceList.isNotEmpty
                  ? FormRow(
                      dropDownCallback: (description) {
                        widget.formController.buildComponentTwo
                            .fireplaceBOPDescription = description.name;
                        widget.formController.buildComponentTwo
                            .fireplaceCredit = description.value;
                      },
                      dropDownInitial: widget.formController.buildComponentTwo
                              .fireplaceBOPDescription.isEmpty
                          ? getFirePlaceList.first.name
                          : widget.formController.buildComponentTwo
                              .fireplaceBOPDescription,
                      descriptionList: List.from(getFirePlaceList),
                      verificationList: widget.formController.getVerification(),
                      verifiedCallback: (verified) {
                        widget.formController.buildComponentTwo
                            .fireplaceVerification = verified;
                      },
                      isModel: true,
                      isImage: true,
                      isMake: true,
                      makeCallback: (make) {
                        widget.formController.buildComponentTwo.fireplaceMake =
                            make;
                      },
                      makeInitial:
                          widget.formController.buildComponentTwo.fireplaceMake,
                      modelCallback: (model) {
                        widget.formController.buildComponentTwo.fireplaceModel =
                            model;
                      },
                      modelInitial: widget
                          .formController.buildComponentTwo.fireplaceModel,
                      imgCallback: (image) {
                        widget.formController.buildComponentTwo.fireplaceImage =
                            image;
                      },
                      initialImage: widget
                          .formController.buildComponentTwo.fireplaceImage,
                      verificationInitial: widget.formController
                          .buildComponentTwo.fireplaceVerification,
                      title: "Fireplace",
                    )
                  : const SizedBox(),
              getElectricalList.isNotEmpty
                  ? FormRow(
                      dropDownCallback: (description) {
                        widget.formController.buildComponentTwo
                            .esBOPDescription = description.name;
                        widget.formController.buildComponentTwo.esBOPCredit =
                            description.value;
                      },
                      dropDownInitial: widget.formController.buildComponentTwo
                              .esBOPDescription.isEmpty
                          ? getElectricalList.first.name
                          : widget.formController.buildComponentTwo
                              .esBOPDescription,
                      descriptionList: List.from(getElectricalList),
                      verificationList: widget.formController.getVerification(),
                      verifiedCallback: (verified) {
                        widget.formController.buildComponentTwo.esVerification =
                            verified;
                      },
                      isModel: false,
                      isImage: false,
                      isMake: false,
                      verificationInitial: widget
                          .formController.buildComponentTwo.esVerification,
                      title: "Electrical Savings",
                    )
                  : const SizedBox(),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size * .02, vertical: size * .01),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size * .2,
                            child: Padding(
                              padding: EdgeInsets.all(size * .01),
                              child: Text(
                                "Solar PV",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: size * .02),
                              ),
                            ),
                          ),
                          RadioGroupCustom(
                            isBG: false,
                            list: widget.formController.getVerification(),
                            callback: (value) {
                              widget.formController.buildComponentTwo
                                  .solarPVVerification = value;
                            },
                            selectedItem: widget.formController
                                .buildComponentTwo.solarPVVerification,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.1),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 0)),
                    child: RadioGroupCustom(
                      isBG: false,
                      list: const [
                        "No",
                        "Yes",
                      ],
                      callback: (value) {
                        widget.formController.buildComponentTwo
                            .solarPVRequired = value;
                      },
                      selectedItem: widget
                          .formController.buildComponentTwo.solarPVRequired,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size * .02, vertical: size * .01),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size * .2,
                            child: Padding(
                              padding: EdgeInsets.all(size * .01),
                              child: Text(
                                "Energy Monitor",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: size * .02),
                              ),
                            ),
                          ),
                          RadioGroupCustom(
                            isBG: false,
                            list: widget.formController.getVerification(),
                            callback: (value) {
                              widget.formController.buildComponentTwo
                                  .energyMonitorVerification = value;
                            },
                            selectedItem: widget.formController
                                .buildComponentTwo.energyMonitorVerification,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.1),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 0)),
                    child: RadioGroupCustom(
                      isBG: false,
                      list: const [
                        "No",
                        "Yes",
                      ],
                      callback: (value) {
                        widget.formController.buildComponentTwo
                            .energyMonitorRequired = value;
                      },
                      selectedItem: widget.formController.buildComponentTwo
                          .energyMonitorRequired,
                    ),
                  ),
                ],
              ),
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
                      widget.formController.buildComponentTwo.comments,
                  onChanged: (input) {
                    widget.formController.buildComponentTwo.comments = input;
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
