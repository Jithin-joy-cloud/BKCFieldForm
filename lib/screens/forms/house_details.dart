import 'dart:convert';

import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/utils/remoteConfig.dart';
import 'package:bkc_field_form/widgets/radioGroupCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HouseDetail extends StatefulWidget {
  final FormController formController;

  const HouseDetail({
    Key? key,
    required this.formController,
  }) : super(key: key);

  @override
  HomeDetailsState createState() => HomeDetailsState();
}

class HomeDetailsState extends State<HouseDetail> {
  final size = currentDevice.value.height;
  List getAttDetList = [];
  List getMidEndList = [];

  initializeFormOne() {
    widget.formController.house.att_det_murb =
        widget.formController.house.att_det_murb.isEmpty
            ? getAttDetList.first
            : widget.formController.house.att_det_murb;
    widget.formController.house.mid_end_ =
        widget.formController.house.mid_end_.isEmpty
            ? getMidEndList.first
            : widget.formController.house.mid_end_;
  }

  Future<void> initList() async {
    getAttDetList = await widget.formController.getAttDetMurb();
    getMidEndList = await widget.formController.getMidEnd();
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
          child: Padding(
            padding: EdgeInsets.all(size * .01),
            child: Column(
              children: [
                Text(
                  "House Details",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size * .03),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  initialValue: widget.formController.house.site,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 15,
                  onChanged: (input) {
                    widget.formController.house.site = input;
                  },
                  validator: (value) {
                    if (value!.length < 2 || value.length > 24) {
                      return "Please enter a valid site";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "site"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  initialValue: widget.formController.house.phase == null
                      ? ""
                      : widget.formController.house.phase.toString(),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 15,
                  onChanged: (input) {
                    if(input.isNotEmpty){
                      widget.formController.house.phase = int.parse(input);
                    }
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null) {
                      return "Please enter a valid Phase";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "Phase"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  initialValue: widget.formController.house.lot == null
                      ? ""
                      : widget.formController.house.lot.toString(),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 15,
                  onChanged: (input) {
                   if(input.isNotEmpty){
                     widget.formController.house.lot = int.parse(input);
                   }
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please enter a valid lot";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "lot"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  initialValue: widget.formController.house.address,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 20,
                  inputFormatters: [UpperCaseTextFormatter()],
                  onChanged: (input) {
                    widget.formController.house.address = input;
                  },
                  validator: (value) {
                    if (value!.length < 2) {
                      return "Please enter a valid address";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "address"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  initialValue: widget.formController.house.city,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 15,
                  onChanged: (input) {
                    widget.formController.house.city = input;
                  },
                  validator: (value) {
                    if (value!.length < 2) {
                      return "Please enter a valid city";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "city"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  initialValue: widget.formController.house.postalCode,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 6,
                  inputFormatters: [UpperCaseTextFormatter()],
                  onChanged: (input) {
                    widget.formController.house.postalCode = input;
                  },
                  validator: (value) {
                    if (value!.length != 6) {
                      return "Please enter a valid postal code";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "postal code"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  initialValue: widget.formController.house.province,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 15,
                  onChanged: (input) {
                    widget.formController.house.province = input;
                  },
                  validator: (value) {
                    if (value!.length < 2 || value.length > 14) {
                      return "Please enter a valid province";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "province"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  initialValue: widget.formController.house.direction,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 15,
                  onChanged: (input) {
                    widget.formController.house.direction = input;
                  },
                  validator: (value) {
                    if (value!.length < 2 || value.length > 14) {
                      return "Please enter a valid direction";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "direction"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  initialValue: widget.formController.house.specialCondition,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 15,
                  onChanged: (input) {
                    widget.formController.house.specialCondition = input;
                  },
                  validator: (value) {
                    if (value!.length < 2 || value.length > 14) {
                      return "Please enter a valid Special condition";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "Special condition"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  initialValue: widget.formController.house.modelName,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 15,
                  onChanged: (input) {
                    widget.formController.house.modelName = input;
                  },
                  validator: (value) {
                    if (value!.length < 2 || value.length > 14) {
                      return "Please enter a valid Model name";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "Model name"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  initialValue: widget.formController.house.volume == null
                      ? ""
                      : widget.formController.house.volume.toString(),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 15,
                  onChanged: (input) {
                   if(input.isNotEmpty){
                     widget.formController.house.volume = double.parse(input);
                   }
                  },
                  validator: (value) {
                    if (value!.toString().isEmpty) {
                      return "Please enter a valid volume";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "volume"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xff128841)),
                  initialValue: widget.formController.house.surfaceArea == null
                      ? ""
                      : widget.formController.house.surfaceArea.toString(),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 15,
                  onChanged: (input) {
                    if(input.isNotEmpty){
                      widget.formController.house.surfaceArea =
                          double.parse(input);
                    }
                  },
                  validator: (value) {
                    if (value!.toString().isEmpty) {
                      return "Please enter a Surface area";
                    } else {
                      return null;
                    }
                  },
                  decoration: showDecoration(size, "Surface Area"),
                ),
                SizedBox(
                  height: size * .03,
                ),
                getAttDetList.isNotEmpty? RadioGroupCustom(
                  isBG: true,
                  list: List.from(getAttDetList),
                  callback: (value) {
                    widget.formController.house.att_det_murb = value;
                  },
                  selectedItem: widget.formController.house.att_det_murb,
                ):const SizedBox(),
                SizedBox(
                  height: size * .03,
                ),
                getMidEndList.isNotEmpty?RadioGroupCustom(
                  list: List.from(getMidEndList),
                  callback: (value) {
                    widget.formController.house.mid_end_ = value;
                  },
                  isBG: true,
                  selectedItem: widget.formController.house.mid_end_,
                ):const SizedBox(),
                SizedBox(
                  height: size * .07,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}

InputDecoration showDecoration(double size, String hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      horizontal: size * .022,
    ),
    hintText: hint,
    counterText: "",
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
