import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/widgets/dropDownCustom.dart';
import 'package:bkc_field_form/widgets/formRow.dart';
import 'package:bkc_field_form/widgets/radioGroupCustom.dart';
import 'package:flutter/material.dart';

import '../../utils/remoteConfig.dart';

class FormThree extends StatefulWidget {
  final FormController formController;

  const FormThree({
    Key? key,
    required this.formController,
  }) : super(key: key);

  @override
  FormThreeState createState() => FormThreeState();
}

class FormThreeState extends State<FormThree> {
  final size = currentDevice.value.height;
  List getSpaceHeatList = [];
  List getSpaceCoolingList = [];
  List getDomesticHotList = [];
  List getDrainWaterList = [];
  List getAirTightnessList = [];
  List getVentilationList = [];

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
            size * .03,
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
          initializeFormThree();
        });
      });
    });

    super.initState();
  }

  Future<void> initList() async {
    getSpaceHeatList = await widget.formController.getSpaceHeating();
    getSpaceCoolingList = await widget.formController.getSpaceCooling();
    getDomesticHotList = await widget.formController.getDomesticHotWater();
    getDrainWaterList = await widget.formController.getDrainWaterHeatRecovery();
    getAirTightnessList = await widget.formController.getAirTightness();
    getVentilationList = await widget.formController.getVentilation();
  }

  void initializeFormThree() {
    widget
        .formController.buildComponentThree.spaceHeatingBOPDescription = widget
            .formController
            .buildComponentThree
            .spaceHeatingBOPDescription
            .isEmpty
        ? getSpaceHeatList.first.name
        : widget.formController.buildComponentThree.spaceHeatingBOPDescription;
    widget.formController.buildComponentThree.spaceHeatingCredit =
        widget.formController.buildComponentThree.spaceHeatingCredit.isEmpty
            ? getSpaceHeatList.first.value
            : widget.formController.buildComponentThree.spaceHeatingCredit;

    widget
        .formController.buildComponentThree.spaceCoolingBOPDescription = widget
            .formController
            .buildComponentThree
            .spaceCoolingBOPDescription
            .isEmpty
        ? getSpaceCoolingList.first.name
        : widget.formController.buildComponentThree.spaceCoolingBOPDescription;
    widget.formController.buildComponentThree.spaceCoolingCredit =
        widget.formController.buildComponentThree.spaceCoolingCredit.isEmpty
            ? getSpaceCoolingList.first.value
            : widget.formController.buildComponentThree.spaceCoolingCredit;

    widget.formController.buildComponentThree.domesticHotWaterBOPDescription =
        widget.formController.buildComponentThree.domesticHotWaterBOPDescription
                .isEmpty
            ? getDomesticHotList.first.name
            : widget.formController.buildComponentThree
                .domesticHotWaterBOPDescription;
    widget.formController.buildComponentThree.domesticHotWaterCredit =
        widget.formController.buildComponentThree.domesticHotWaterCredit.isEmpty
            ? getDomesticHotList.first.value
            : widget.formController.buildComponentThree.domesticHotWaterCredit;

    widget.formController.buildComponentThree.drainWaterBOPDescription = widget
            .formController.buildComponentThree.drainWaterBOPDescription.isEmpty
        ? getDrainWaterList.first.name
        : widget.formController.buildComponentThree.drainWaterBOPDescription;

    widget.formController.buildComponentThree.drainWaterCredit =
        widget.formController.buildComponentThree.drainWaterCredit.isEmpty
            ? getDrainWaterList.first.value
            : widget.formController.buildComponentThree.drainWaterCredit;

    widget
        .formController.buildComponentThree.airTightnessBOPDescription = widget
            .formController
            .buildComponentThree
            .airTightnessBOPDescription
            .isEmpty
        ? getAirTightnessList.first.name
        : widget.formController.buildComponentThree.airTightnessBOPDescription;

    widget.formController.buildComponentThree.airTightnessCredit =
        widget.formController.buildComponentThree.airTightnessCredit.isEmpty
            ? getAirTightnessList.first.value
            : widget.formController.buildComponentThree.airTightnessCredit;

    widget.formController.buildComponentThree.ventilationBOPDescription = widget
            .formController
            .buildComponentThree
            .ventilationBOPDescription
            .isEmpty
        ? getVentilationList.first.name
        : widget.formController.buildComponentThree.ventilationBOPDescription;

    widget.formController.buildComponentThree.ventilationCredit =
        widget.formController.buildComponentThree.ventilationCredit.isEmpty
            ? getVentilationList.first.value
            : widget.formController.buildComponentThree.ventilationCredit;

    widget.formController.buildComponentThree.ductSealingRequired.isEmpty
        ? widget.formController.buildComponentThree.ductSealingRequired = "No"
        : widget.formController.buildComponentThree.ductSealingRequired;

    widget.formController.buildComponentThree.furnaceFan.isEmpty
        ? widget.formController.buildComponentThree.furnaceFan = "No"
        : widget.formController.buildComponentThree.furnaceFan;

    widget.formController.buildComponentThree.hrvBalanced.isEmpty
        ? widget.formController.buildComponentThree.hrvBalanced = "No"
        : widget.formController.buildComponentThree.hrvBalanced;
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
                "Air Tightness",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size * .03),
              ),
              getSpaceHeatList.isNotEmpty
                  ? FormRow(
                      dropDownCallback: (description) {
                        widget.formController.buildComponentThree
                            .spaceHeatingBOPDescription = description.name;
                        widget.formController.buildComponentThree
                            .spaceHeatingCredit = description.value;
                      },
                      dropDownInitial: widget.formController.buildComponentThree
                              .spaceHeatingBOPDescription.isEmpty
                          ? getSpaceHeatList.first.name
                          : widget.formController.buildComponentThree
                              .spaceHeatingBOPDescription,
                      descriptionList: List.from(getSpaceHeatList),
                      verificationList: widget.formController.getVerification(),
                      verifiedCallback: (verified) {
                        widget.formController.buildComponentThree
                            .spaceHeatingVerification = verified;
                      },
                      isModel: true,
                      isImage: true,
                      isMake: true,
                      makeCallback: (make) {
                        widget.formController.buildComponentThree
                            .spaceHeatingMake = make;
                      },
                      makeInitial: widget
                          .formController.buildComponentThree.spaceHeatingMake,
                      modelCallback: (model) {
                        widget.formController.buildComponentThree
                            .spaceHeatingModel = model;
                      },
                      modelInitial: widget
                          .formController.buildComponentThree.spaceHeatingModel,
                      imgCallback: (image) {
                        widget.formController.buildComponentThree
                            .spaceHeatingImage = image;
                      },
                      initialImage: widget
                          .formController.buildComponentThree.spaceHeatingImage,
                      verificationInitial: widget.formController
                          .buildComponentThree.spaceHeatingVerification,
                      title: "Space\nHeating",
                    )
                  : const SizedBox(),
              getSpaceCoolingList.isNotEmpty
                  ? FormRow(
                      dropDownCallback: (description) {
                        widget.formController.buildComponentThree
                            .spaceCoolingBOPDescription = description.name;
                        widget.formController.buildComponentThree
                            .spaceCoolingCredit = description.value;
                      },
                      dropDownInitial: widget.formController.buildComponentThree
                              .spaceCoolingBOPDescription.isEmpty
                          ? getSpaceCoolingList.first.name
                          : widget.formController.buildComponentThree
                              .spaceCoolingBOPDescription,
                      descriptionList: List.from(getSpaceCoolingList),
                      verificationList: widget.formController.getVerification(),
                      verifiedCallback: (verified) {
                        widget.formController.buildComponentThree
                            .spaceCoolingVerification = verified;
                      },
                      isModel: true,
                      isImage: true,
                      isMake: true,
                      makeCallback: (make) {
                        widget.formController.buildComponentThree
                            .spaceCoolingMake = make;
                      },
                      makeInitial: widget
                          .formController.buildComponentThree.spaceCoolingMake,
                      modelCallback: (model) {
                        widget.formController.buildComponentThree
                            .spaceCoolingModel = model;
                      },
                      modelInitial: widget
                          .formController.buildComponentThree.spaceCoolingModel,
                      imgCallback: (image) {
                        widget.formController.buildComponentThree
                            .spaceCoolingImage = image;
                      },
                      initialImage: widget
                          .formController.buildComponentThree.spaceCoolingImage,
                      verificationInitial: widget.formController
                          .buildComponentThree.spaceCoolingVerification,
                      title: "Space\nCooling",
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
                            child: Text(
                              "Duct Sealing",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size * .02),
                            ),
                          ),
                          RadioGroupCustom(
                            isBG: false,
                            list: widget.formController.getVerification(),
                            callback: (value) {
                              widget.formController.buildComponentThree
                                  .ductSealingVerification = value;
                            },
                            selectedItem: widget.formController
                                .buildComponentThree.ductSealingVerification,
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
                        widget.formController.buildComponentThree
                            .ductSealingRequired = value;
                      },
                      selectedItem: widget.formController.buildComponentThree
                          .ductSealingRequired,
                    ),
                  ),
                ],
              ),
              getDomesticHotList.isNotEmpty
                  ? FormRow(
                      dropDownCallback: (description) {
                        widget.formController.buildComponentThree
                            .domesticHotWaterBOPDescription = description.name;
                        widget.formController.buildComponentThree
                            .domesticHotWaterCredit = description.name;
                      },
                      dropDownInitial: widget.formController.buildComponentThree
                              .domesticHotWaterBOPDescription.isEmpty
                          ? getDomesticHotList.first.name
                          : widget.formController.buildComponentThree
                              .domesticHotWaterBOPDescription,
                      descriptionList: List.from(getDomesticHotList),
                      verificationList: widget.formController.getVerification(),
                      verifiedCallback: (verified) {
                        widget.formController.buildComponentThree
                            .domesticHotWaterVerification = verified;
                      },
                      isModel: true,
                      isImage: true,
                      isMake: true,
                      makeCallback: (make) {
                        widget.formController.buildComponentThree
                            .domesticHotWaterMake = make;
                      },
                      makeInitial: widget.formController.buildComponentThree
                          .domesticHotWaterMake,
                      modelCallback: (model) {
                        widget.formController.buildComponentThree
                            .domesticHotWaterModel = model;
                      },
                      modelInitial: widget.formController.buildComponentThree
                          .domesticHotWaterModel,
                      imgCallback: (image) {
                        widget.formController.buildComponentThree
                            .domesticHotWaterImage = image;
                      },
                      initialImage: widget.formController.buildComponentThree
                          .domesticHotWaterImage,
                      verificationInitial: widget.formController
                          .buildComponentThree.domesticHotWaterVerification,
                      title: "Domestic\nHot water",
                    )
                  : const SizedBox(),
              getDrainWaterList.isNotEmpty
                  ? FormRow(
                      dropDownCallback: (description) {
                        widget.formController.buildComponentThree
                            .drainWaterBOPDescription = description.name;
                        widget.formController.buildComponentThree
                            .drainWaterCredit = description.value;
                      },
                      dropDownInitial: widget.formController.buildComponentThree
                              .drainWaterBOPDescription.isEmpty
                          ? getDrainWaterList.first.name
                          : widget.formController.buildComponentThree
                              .drainWaterBOPDescription,
                      descriptionList: List.from(getDrainWaterList),
                      verificationList: widget.formController.getVerification(),
                      verifiedCallback: (verified) {
                        widget.formController.buildComponentThree
                            .drainWaterVerification = verified;
                      },
                      isModel: true,
                      isImage: true,
                      isMake: true,
                      makeCallback: (make) {
                        widget.formController.buildComponentThree
                            .drainWaterMake = make;
                      },
                      makeInitial: widget
                          .formController.buildComponentThree.drainWaterMake,
                      modelCallback: (model) {
                        widget.formController.buildComponentThree
                            .drainWaterModel = model;
                      },
                      modelInitial: widget
                          .formController.buildComponentThree.drainWaterModel,
                      imgCallback: (image) {
                        widget.formController.buildComponentThree
                            .drainWaterImage = image;
                      },
                      initialImage: widget
                          .formController.buildComponentThree.drainWaterImage,
                      verificationInitial: widget.formController
                          .buildComponentThree.drainWaterVerification,
                      title: "Drain water\nHeat recovery",
                    )
                  : const SizedBox(),
              Column(
                children: [
                  getAirTightnessList.isNotEmpty
                      ? FormRow(
                          dropDownCallback: (description) {
                            widget.formController.buildComponentThree
                                .airTightnessBOPDescription = description.name;
                            widget.formController.buildComponentThree
                                .airTightnessCredit = description.value;
                          },
                          dropDownInitial: widget
                                  .formController
                                  .buildComponentThree
                                  .airTightnessBOPDescription
                                  .isEmpty
                              ? getAirTightnessList.first.name
                              : widget.formController.buildComponentThree
                                  .airTightnessBOPDescription,
                          descriptionList: List.from(getAirTightnessList),
                          verificationList:
                              widget.formController.getVerification(),
                          verifiedCallback: (verified) {
                            widget.formController.buildComponentThree
                                .airTightnessVerification = verified;
                          },
                          isModel: false,
                          isImage: false,
                          isMake: false,
                          verificationInitial: widget.formController
                              .buildComponentThree.airTightnessVerification,
                          title: "Air Tightness",
                        )
                      : const SizedBox(),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.1),
                        border: Border.symmetric(
                            vertical: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 0))),
                    child: Padding(
                      padding: EdgeInsets.all(size * .01),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(color: Color(0xff128841)),
                              initialValue: widget.formController
                                  .buildComponentThree.airTightnessNLR,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLength: 15,
                              onChanged: (input) {
                                widget.formController.buildComponentThree
                                    .airTightnessNLR = input;
                              },
                              validator: (value) {
                                if (value!.toString().isEmpty) {
                                  return "Please enter a model NLR";
                                } else {
                                  return null;
                                }
                              },
                              decoration: showDecoration(size, "NLR"),
                            ),
                          ),
                          SizedBox(
                            width: size * .009,
                          ),
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(color: Color(0xff128841)),
                              initialValue: widget.formController
                                  .buildComponentThree.airTightnessACH,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLength: 15,
                              onChanged: (input) {
                                widget.formController.buildComponentThree
                                    .airTightnessACH = input;
                              },
                              validator: (value) {
                                if (value!.toString().isEmpty) {
                                  return "Please enter a ACH";
                                } else {
                                  return null;
                                }
                              },
                              decoration: showDecoration(size, "ACH"),
                            ),
                          ),
                          SizedBox(
                            width: size * .009,
                          ),
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(color: Color(0xff128841)),
                              initialValue: widget.formController
                                  .buildComponentThree.airTightnessEQLA,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLength: 15,
                              onChanged: (input) {
                                widget.formController.buildComponentThree
                                    .airTightnessEQLA = input;
                              },
                              validator: (value) {
                                if (value!.toString().isEmpty) {
                                  return "Please enter a EQLA";
                                } else {
                                  return null;
                                }
                              },
                              decoration: showDecoration(size, "EQLA"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  getVentilationList.isNotEmpty
                      ? FormRow(
                          dropDownCallback: (description) {
                            widget.formController.buildComponentThree
                                .ventilationBOPDescription = description.name;
                            widget.formController.buildComponentThree
                                .ventilationCredit = description.value;
                          },
                          dropDownInitial: widget
                                  .formController
                                  .buildComponentThree
                                  .ventilationBOPDescription
                                  .isEmpty
                              ? getVentilationList.first.name
                              : widget.formController.buildComponentThree
                                  .ventilationBOPDescription,
                          descriptionList: List.from(getVentilationList),
                          verificationList:
                              widget.formController.getVerification(),
                          verifiedCallback: (verified) {
                            widget.formController.buildComponentThree
                                .ventilationVerification = verified;
                          },
                          isModel: true,
                          isImage: true,
                          isMake: true,
                          makeCallback: (make) {
                            widget.formController.buildComponentThree
                                .ventilationMake = make;
                          },
                          makeInitial: widget.formController.buildComponentThree
                              .ventilationMake,
                          modelCallback: (model) {
                            widget.formController.buildComponentThree
                                .ventilationModel = model;
                          },
                          modelInitial: widget.formController
                              .buildComponentThree.ventilationModel,
                          imgCallback: (image) {
                            widget.formController.buildComponentThree
                                .ventilationImage = image;
                          },
                          initialImage: widget.formController
                              .buildComponentThree.ventilationImage,
                          verificationInitial: widget.formController
                              .buildComponentThree.ventilationVerification,
                          title: "Ventilation",
                        )
                      : const SizedBox(),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.1),
                        border: Border.symmetric(
                            vertical: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 0))),
                    child: Padding(
                      padding: EdgeInsets.all(size * .01),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Furnace fan",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: size * .015),
                                    ),
                                    RadioGroupCustom(
                                      isBG: false,
                                      list: const [
                                        "No",
                                        "Yes",
                                      ],
                                      callback: (value) {
                                        widget
                                            .formController
                                            .buildComponentThree
                                            .furnaceFan = value;
                                      },
                                      selectedItem: widget.formController
                                          .buildComponentThree.furnaceFan,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hrv balanced",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: size * .015),
                                    ),
                                    RadioGroupCustom(
                                      isBG: false,
                                      list: const [
                                        "No",
                                        "Yes",
                                      ],
                                      callback: (value) {
                                        widget
                                            .formController
                                            .buildComponentThree
                                            .hrvBalanced = value;
                                      },
                                      selectedItem: widget.formController
                                          .buildComponentThree.hrvBalanced,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      style: const TextStyle(
                                          color: Color(0xff128841)),
                                      initialValue: widget.formController
                                          .buildComponentThree.ventilationFresh,
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      maxLength: 15,
                                      onChanged: (input) {
                                        widget
                                            .formController
                                            .buildComponentThree
                                            .ventilationFresh = input;
                                      },
                                      validator: (value) {
                                        if (value!.toString().isEmpty) {
                                          return "Please enter a Fresh";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: showDecoration(size, "fresh"),
                                    ),
                                    SizedBox(
                                      height: size * .01,
                                    ),
                                    TextFormField(
                                      style: const TextStyle(
                                          color: Color(0xff128841)),
                                      initialValue: widget.formController
                                          .buildComponentThree.ventilationStale,
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      maxLength: 15,
                                      onChanged: (input) {
                                        widget
                                            .formController
                                            .buildComponentThree
                                            .ventilationStale = input;
                                      },
                                      validator: (value) {
                                        if (value!.toString().isEmpty) {
                                          return "Please enter a Fresh";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: showDecoration(size, "Stale"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: size * .25,
                              child: TextFormField(
                                style:
                                    const TextStyle(color: Color(0xff128841)),
                                initialValue: widget.formController
                                    .buildComponentThree.bedroomCount
                                    .toString(),
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 15,
                                onChanged: (input) {
                                  if (input.isNotEmpty) {
                                    widget.formController.buildComponentThree
                                        .bedroomCount = int.parse(input);
                                  }
                                },
                                validator: (value) {
                                  if (value!.toString().isEmpty) {
                                    return "Please enter a Bedroom Count";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration:
                                    showDecoration(size, "Bed Room Count"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size * .01,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size * .03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size * .02, vertical: size * .01),
                child: TextFormField(
                  style: const TextStyle(
                    color: Color(0xff128841),
                  ),
                  maxLines: null,
                  initialValue:
                      widget.formController.buildComponentThree.comments,
                  onChanged: (input) {
                    widget.formController.buildComponentThree.comments = input;
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
