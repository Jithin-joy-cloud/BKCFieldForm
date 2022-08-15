import 'dart:ui';

import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/main.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/models/general_details.dart';
import 'package:bkc_field_form/repository/user_repository.dart';
import 'package:bkc_field_form/widgets/datePicker.dart';
import 'package:bkc_field_form/widgets/textFieldCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralDetails extends StatefulWidget {
  final FormController formController;

  const GeneralDetails({
    Key? key,
    required this.formController,
  }) : super(key: key);

  @override
  GeneralDetailsState createState() => GeneralDetailsState();
}

class GeneralDetailsState extends State<GeneralDetails> {
  final size = currentDevice.value.height;
  final _mobileFormatter = _NumberTextInputFormatter();
  List<General>? generalList;

  @override
  void initState() {
    objectBox.getGeneralDetails().then((value) {
      generalList = [General()];
      generalList!.clear();
      if (value!.isNotEmpty) {
        generalList!.addAll(value);
      }
      widget.formController.general.evaluatorId =
          widget.formController.general.evaluatorId ??
              int.parse(currentUser.value.employeeID);
      widget.formController.general.evaluatorName =
      widget.formController.general.evaluatorName.isEmpty
          ? currentUser.value.username
          : widget.formController.general.evaluatorName;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size * .01),
          child: Column(
            children: [
              Text(
                "General Details",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size * .03),
              ),
              SizedBox(
                height: size * .03,
              ),
              Autocomplete<General>(
                optionsMaxHeight: 50,
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<General>.empty();
                  } else if (generalList != null) {
                    return generalList!.where((word) => word.enrolmentId
                        .toLowerCase()
                        .startsWith(textEditingValue.text.toLowerCase()));
                  }
                  return const Iterable<General>.empty();
                },
                optionsViewBuilder:
                    (context, Function(General) onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4,
                      color: Theme.of(context).cardColor,
                      child: SizedBox(
                        width: size * .5,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final option = options.elementAt(index);
                            return ListTile(
                              title: Text(
                                option.enrolmentId,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              onTap: () {
                                onSelected(option);
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 1,
                          ),
                          itemCount: options.length,
                        ),
                      ),
                    ),
                  );
                },
                displayStringForOption: (General general) =>
                    general.enrolmentId,
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  textEditingController.text =
                      widget.formController.general.enrolmentId;
                  return TextFormField(
                    controller: textEditingController,
                    decoration: showDecoration(size, "EsEnrolment ID"),
                    focusNode: focusNode,
                    keyboardType: TextInputType.text,
                    onChanged: (enrolment) {
                      widget.formController.general.enrolmentId = enrolment;
                    },
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 14,
                    inputFormatters: [UpperCaseTextFormatter()],
                    validator: (value) {
                      if (value!.length < 2 || value.length > 14) {
                        return "Please enter a valid EsEnrolment ID";
                      } else {
                        return null;
                      }
                    },
                  );
                },
                onSelected: (General selection) {
                  widget.formController.general.enrolmentId =
                      selection.enrolmentId;
                },
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.alt_file_id,
                keyboardType: TextInputType.text,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 14,
                onChanged: (input) {
                  widget.formController.general.alt_file_id = input;
                },
                validator: (value) {
                  if (value!.length < 2 || value.length > 14) {
                    return "Please enter a valid Alternative File ID";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "Alternative File ID"),
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.chba_nz_file,
                keyboardType: TextInputType.text,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 14,
                onChanged: (input) {
                  widget.formController.general.chba_nz_file = input;
                },
                validator: (value) {
                  if (value!.length < 2 || value.length > 14) {
                    return "Please enter a valid CHBA NZ File #";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "CHBA NZ File #"),
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.perspective,
                keyboardType: TextInputType.text,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 24,
                onChanged: (input) {
                  widget.formController.general.perspective = input;
                },
                validator: (value) {
                  if (value!.length < 2 || value.length > 24) {
                    return "Please enter a valid Prescriptive or Performance";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "Prescriptive or Performance"),
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.soName,
                keyboardType: TextInputType.text,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 14,
                onChanged: (input) {
                  widget.formController.general.soName = input;
                },
                validator: (value) {
                  if (value!.length < 2 || value.length > 14) {
                    return "Please enter a valid SO Name and #";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "SO Name and #"),
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.hddZone,
                keyboardType: TextInputType.text,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 15,
                onChanged: (input) {
                  widget.formController.general.hddZone = input;
                },
                validator: (value) {
                  if (value!.length < 2 || value.length > 14) {
                    return "Please enter a valid HDD Zone";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "HDD Zone"),
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.builderName,
                keyboardType: TextInputType.text,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 15,
                inputFormatters: [UpperCaseTextFormatter()],
                onChanged: (input) {
                  widget.formController.general.builderName = input;
                },
                validator: (value) {
                  if (value!.length < 2 || value.length > 24) {
                    return "Please enter a valid Builder Name";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "Builder Name"),
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.builderId != null
                    ? widget.formController.general.builderId.toString()
                    : "",
                keyboardType: TextInputType.number,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 15,
                onChanged: (input) {
                  widget.formController.general.builderId = int.parse(input);
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a valid Builder ID";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "Builder ID"),
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue:
                    widget.formController.general.evaluatorName.isEmpty
                        ? currentUser.value.username
                        : widget.formController.general.evaluatorName,
                keyboardType: TextInputType.text,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 15,
                onChanged: (input) {
                  widget.formController.general.evaluatorName = input;
                },
                validator: (value) {
                  if (value!.length < 2 || value.length > 24) {
                    return "Please enter a valid Evaluator Name";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "Evaluator Name"),
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.evaluatorId != null
                    ? widget.formController.general.evaluatorId.toString()
                    : currentUser.value.employeeID,
                keyboardType: TextInputType.number,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 15,
                onChanged: (input) {
                  widget.formController.general.evaluatorId = int.parse(input);
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.length != 4) {
                    return "Please enter a valid Evaluator Number";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "Evaluator Number"),
              ),
              SizedBox(
                height: size * .03,
              ),
              PickDate(
                date: "Inspection date",
                initialValue: widget.formController.general.inspectionDate,
                dateCallback: (String value) {
                  widget.formController.general.inspectionDate = value;
                },
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.fieldTechnician,
                keyboardType: TextInputType.text,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 15,
                onChanged: (input) {
                  widget.formController.general.fieldTechnician = input;
                },
                validator: (value) {
                  if (value!.length < 2 || value.length > 24) {
                    return "Please enter a valid Field Technician";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "Field Technician"),
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.siteContactName,
                keyboardType: TextInputType.text,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 15,
                onChanged: (input) {
                  widget.formController.general.siteContactName = input;
                },
                validator: (value) {
                  if (value!.length < 2 || value.length > 24) {
                    return "Please enter a valid site contact name";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "site contact name"),
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.siteContactNumber,
                keyboardType: TextInputType.phone,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 15,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  _mobileFormatter,
                ],
                onChanged: (input) {
                  widget.formController.general.siteContactNumber = input;
                },
                validator: (value) {
                  bool phoneValid =
                      RegExp(r"^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$")
                          .hasMatch(value!);
                  if (!phoneValid) {
                    return "Please enter a valid phone number";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "site contact phone"),
              ),
              SizedBox(
                height: size * .03,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xff128841)),
                initialValue: widget.formController.general.siteContactEmail,
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 25,
                onChanged: (input) {
                  widget.formController.general.siteContactEmail = input;
                },
                validator: (value) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);

                  if (!emailValid) {
                    return "Please enter a valid email";
                  } else {
                    return null;
                  }
                },
                decoration: showDecoration(size, "site contact email"),
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

class _NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
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
