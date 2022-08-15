import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/models/descriprion.dart';
import 'package:bkc_field_form/widgets/dropDownCustom.dart';
import 'package:bkc_field_form/widgets/radioGroupCustom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormRow extends StatefulWidget {
  final List<Description> descriptionList;
  final String dropDownInitial;
  final List<String> verificationList;
  final String makeInitial;
  final String title;
  final ValueSetter<String>? makeCallback;
  final String modelInitial;
  final ValueSetter<String>? modelCallback;
  final ValueSetter<Description>? dropDownCallback;
  final ValueSetter<String> verifiedCallback;
  final String verificationInitial;
  final ValueSetter<String>? imgCallback;
  final String initialImage;
  final bool isModel;
  final bool isMake;
  final bool isImage;

  const FormRow({
    Key? key,
    required this.descriptionList,
    this.makeInitial = "",
    this.makeCallback,
    this.modelInitial = "",
    this.modelCallback,
    required this.verifiedCallback,
    this.imgCallback,
    required this.isModel,
    required this.isMake,
    required this.isImage,
    required this.verificationList,
    required this.verificationInitial,
    required this.title,
    required this.dropDownInitial,
    this.dropDownCallback,
    this.initialImage = "",
  }) : super(key: key);

  @override
  FormRowState createState() => FormRowState();
}

class FormRowState extends State<FormRow> {
  final size = currentDevice.value.height;
  File? selectedFile;
  String creditInitial = "";

  Future pickImage() async {
    try {
      await ImagePicker()
          .pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      )
          .then((value) async {
        Navigator.of(context).pop();
        if (value == null) return;

        List<int> imageBytes = File(value.path).readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        widget.imgCallback!(base64Image);
        selectedFile = File(value.path);
        setState(() {});
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future captureImage() async {
    try {
      await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 25)
          .then((value) {
        Navigator.of(context).pop();
        if (value == null) return;
        List<int> imageBytes = File(value.path).readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        widget.imgCallback!(base64Image);
        selectedFile = File(value.path);
        setState(() {});
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Expanded getImage() {
    return Expanded(
      flex: 4,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            elevation: 5,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                       bottom: Radius.zero, top: Radius.circular(size * .02)),
                ),
                margin: const EdgeInsets.all(0),
                child: Wrap(children: [
                  InkWell(
                    onTap: () {
                      captureImage();
                    },
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.camera_alt),
                          color: Theme.of(context).canvasColor,
                          onPressed: () {},
                        ),
                        Text(
                          "Pick an image from camera",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: size * .02,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.attach_file),
                          color: Theme.of(context).canvasColor,
                          onPressed: () {
                            pickImage();
                          },
                        ),
                        Text(
                          "Pick an image from gallery",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: size * .02),
                        )
                      ],
                    ),
                  ),
                ]),
              );
            },
          );
        },
        child: Row(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(size * .02),
                  child: AnimatedContainer(
                    width: selectedFile != null ? size * .04 : size * .035,
                    height: selectedFile != null ? size * .04 : size * .035,
                    duration: const Duration(seconds: 2),
                    curve: Curves.bounceIn,
                    child: CircleAvatar(
                      radius: selectedFile != null ? size * .02 : size * .02,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        onPressed: () {},
                        iconSize:
                            selectedFile != null ? size * .02 : size * .015,
                        icon: selectedFile != null
                            ? const Icon(
                                Icons.done,
                              )
                            : const Icon(
                                Icons.image,
                              ),
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                ),
               // Container(child: image(),height: 30,width: 30,),
                FittedBox(
                  child: Text(
                    "Choose image",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: size * .015),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    selectedFile =
        widget.initialImage.isEmpty ? null : File(widget.initialImage);
    creditInitial = widget.descriptionList
        .firstWhere((item) => item.name == widget.dropDownInitial)
        .value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size * .02, vertical: size * .01),
          child: FittedBox(
            child: Row(
              children: [
                SizedBox(
                  width: size * .2,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: size * .02),
                  ),
                ),
                RadioGroupCustom(
                  isBG: false,
                  list: widget.verificationList,
                  callback: (value) {
                    widget.verifiedCallback(value);
                  },
                  selectedItem: widget.verificationInitial,
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.1),
              border: Border.symmetric(
                  vertical: BorderSide(
                      color: Theme.of(context).primaryColor, width: 0))),
          child: Padding(
            padding: EdgeInsets.all(size * .01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              DropDownCustom(
                                selectedItem: widget.dropDownInitial,
                                list: widget.descriptionList,
                                callback: (value) {
                                  widget.dropDownCallback!(value);
                                  creditInitial = value.value;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      flex: 6,
                    ),
                    widget.isImage ? getImage() : const SizedBox()
                  ],
                ),
                SizedBox(
                  height: size * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isMake
                        ? SizedBox(
                            width: size * .23,
                            child: TextFormField(
                              style: const TextStyle(color: Color(0xff128841)),
                              initialValue: widget.makeInitial,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLength: 15,
                              onChanged: (input) {
                                widget.makeCallback!(input);
                              },
                              validator: (value) {
                                if (value!.toString().isEmpty) {
                                  return "Please enter a make";
                                } else {
                                  return null;
                                }
                              },
                              decoration: showDecoration(size, "make"),
                            ),
                          )
                        : const SizedBox(),
                    widget.isModel
                        ? SizedBox(
                            width: size * .23,
                            child: TextFormField(
                              style: const TextStyle(color: Color(0xff128841)),
                              initialValue: widget.modelInitial,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLength: 15,
                              onChanged: (input) {
                                widget.modelCallback!(input);
                              },
                              validator: (value) {
                                if (value!.toString().isEmpty) {
                                  return "Please enter a model model";
                                } else {
                                  return null;
                                }
                              },
                              decoration: showDecoration(size, "model"),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                SizedBox(
                  height: size * .01,
                ),
                SizedBox(
                  width: size * .15,
                  child: TextFormField(
                    style: const TextStyle(color: Color(0xff128841)),
                    readOnly: true,
                    maxLines: 1,
                    controller: TextEditingController(text: creditInitial),
                    onTap: () {},
                    onChanged: (input) {
                      //widget.creditCallback(creditInitial);
                    },
                    validator: (value) {
                      if (value!.toString().isEmpty) {
                        return "Please enter a credit";
                      } else {
                        return null;
                      }
                    },
                    decoration: showDecoration(size, "credit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

InputDecoration showDecoration(double size, String hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      horizontal: size * .023,
      vertical: size * .015,
    ),
    hintText: hint,
    counterText: "",
    isDense: true,
    labelText: hint,
    // hintStyle: TextStyle(color: Theme.of(context).hintColor),
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
