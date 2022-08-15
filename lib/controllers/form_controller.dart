import 'dart:convert';
import 'dart:io';

import 'package:bkc_field_form/models/buildingComponentsTwo.dart';
import 'package:bkc_field_form/models/completeForm.dart';
import 'package:bkc_field_form/models/general_details.dart';
import 'package:bkc_field_form/models/house_details.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/formObjectBox.dart';
import '../main.dart';
import '../models/buildingComponentsThree.dart';
import '../models/buildingComponetsOne.dart';
import '../models/descriprion.dart';
import '../utils/overlay.dart';
import 'package:bkc_field_form/repository/form_repositary.dart' as repository;

import '../utils/remoteConfig.dart';

class FormController extends ControllerMVC {
  //GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  General general = General();
  House house = House();
  BuildComponentOne buildComponentOne = BuildComponentOne();
  BuildComponentTwo buildComponentTwo = BuildComponentTwo();
  BuildComponentThree buildComponentThree = BuildComponentThree();
  late List<CompleteForm> formStream;
  GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldMessengerState> homeScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  late OverlayEntry loader;
  int currentIndex = 0;
  final List<int> backstack = [0];
  List<CompleteForm> forms = [CompleteForm()];

  FormController();

  Future<bool> customPop(BuildContext context) {
    if (backstack.length > 1) {
      backstack.removeAt(backstack.length - 1);
      navigateBack(backstack[backstack.length - 1]);

      return Future.value(false);
    } else {
      switch (context.widget.toString()) {
        case "EditFormScreen":
          Navigator.of(context).pop();
          break;
        case "HomeScreen":
          showDialogue(context);
          return Future.value(true);
        default:
      }

      return Future.value(true);
    }
  }

  Future<bool> editFormPop(BuildContext context) {
    Navigator.pushNamed(context, '/home');
    return Future.value(true);
  }

  showDialogue(
    BuildContext context,
  ) {
    Widget continueButton = TextButton(
      child: const Text("Exit"),
      onPressed: () {
        if (Platform.isAndroid) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        } else {
          exit(0);
        }
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () async {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Exit app",
      ),
      content: const Text(
        "Are you sure you want to exit the app?",
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(msg),
      ));
  }

  void navigateTo(BuildContext context) {
    switch (currentIndex) {
      case 0:
        final generalVerification = general.validateGeneral();
        generalVerification == null
            ? next()
            : showSnackBar(context, generalVerification);
        break;
      case 1:
        final houseVerification = house.validateHouse();

        houseVerification == null
            ? next()
            : showSnackBar(context, houseVerification);
        break;
      default:
        next();
    }
  }

  Future<void> saveToLocal(
      BuildContext context, FormObjectBox objectBox) async {
    loader = ProgressHelper.overlayLoader(context);
    CompleteForm completeForm = CompleteForm();
    completeForm.general.target = general;
    completeForm.house.target = house;
    completeForm.buildComponentOne.target = buildComponentOne;
    completeForm.buildComponentTwo.target = buildComponentTwo;
    completeForm.buildComponentThree.target = buildComponentThree;
    Overlay.of(context)!.insert(loader);
    objectBox.createForm(completeForm).then((value) {
      ProgressHelper.hideLoader(loader);
    }).catchError((e) {
      ProgressHelper.hideLoader(loader);
      showSnackBar(context, e.toString());
    });
  }

  Future<void> updateToLocal(
      BuildContext context, FormObjectBox objectBox, int id) async {
    loader = ProgressHelper.overlayLoader(context);
    CompleteForm completeForm = CompleteForm();
    completeForm.id = id;
    completeForm.general.target = general;
    completeForm.house.target = house;
    completeForm.buildComponentOne.target = buildComponentOne;
    completeForm.buildComponentTwo.target = buildComponentTwo;
    completeForm.buildComponentThree.target = buildComponentThree;
    Overlay.of(context)!.insert(loader);
    objectBox.updateForm(completeForm).then((value) {
      ProgressHelper.hideLoader(loader);
    }).catchError((e) {
      ProgressHelper.hideLoader(loader);
      showSnackBar(context, e.toString());
    });
  }

  void upload(BuildContext context, CompleteForm form) {
    loader = ProgressHelper.overlayLoader(context);
    Overlay.of(context)!.insert(loader);
    repository.upload(form).then((value) {
      ProgressHelper.hideLoader(loader);
      if (value) {
        showSnackBar(context, "Form Uploaded");
        objectBox.deleteFormWithId(form.id);
      } else {
        showSnackBar(context, "Please try again");
      }
    }).catchError((e) {
      ProgressHelper.hideLoader(loader);
      showSnackBar(context, e.toString());
    });
  }

  Future<List<CompleteForm>> getForm(BuildContext context) async {
    List<CompleteForm> result;
    result = [CompleteForm()];
    await repository.getForm().then((value) {
      try {
        result.clear();
        result.addAll(value);
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    });
    return result;
  }

  void next() {
    currentIndex++;
    backstack.add(currentIndex);
    currentIndex = currentIndex;
  }

  void navigateBack(int index) {
    currentIndex = index;

  }

  Future<dynamic> pickFile(BuildContext context) async {
    late General general;
    late House house;
    try {
      loader = ProgressHelper.overlayLoader(context);
      Overlay.of(context)!.insert(loader);
      FilePickerResult? file = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['xlsx', 'csv', 'xls'],);

      if (file != null && file.files.isNotEmpty) {
        var bytes = File(file.files.first.path!).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);
        Map<String, dynamic> generalMap = {};
        Map<String, dynamic> houseMap = {};
        for (int rowIndex = 1; rowIndex < 15; rowIndex++) {
          Sheet sheetObject = excel['Inspection Form'];
          generalMap[sheetObject
                  .cell(CellIndex.indexByColumnRow(
                      columnIndex: 0, rowIndex: rowIndex))
                  .value
                  .toString()] =
              sheetObject
                  .cell(CellIndex.indexByColumnRow(
                      columnIndex: 1, rowIndex: rowIndex))
                  .value;
          houseMap[sheetObject
                  .cell(CellIndex.indexByColumnRow(
                      columnIndex: 2, rowIndex: rowIndex))
                  .value
                  .toString()] =
              sheetObject
                  .cell(CellIndex.indexByColumnRow(
                      columnIndex: 3, rowIndex: rowIndex))
                  .value;
        }
        general = General.fromJSONExcel(generalMap);
        house = House.fromJSONExcel(houseMap);
        ProgressHelper.hideLoader(loader);
        return [general, house];
      } else {
        ProgressHelper.hideLoader(loader);
        return null;
      }
    } catch (e) {
      ProgressHelper.hideLoader(loader);
      showSnackBar(context, "Please allow the permission to continue");
    }
  }

  Future<String> getPreference(String key) async {
    String value = "";
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(key)) {
        value = prefs.getString(key)!;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return value;
  }

  Future<List<String>> getAttDetMurb() async {
    var list = ["Attached", "Detached", "Murb"];
    await getPreference("houseDetails").then((value) {
      if (value.isNotEmpty) {
        list = List<String>.from(json.decode(value)['getAttDetMurb']);
      } else {
        list = ["Attached", "Detached", "Murb"];
      }
    });
    return list;
  }

  Future<List<String>> getMidEnd() async {
    var list = ["Mid", "End", "NA"];
    await getPreference("houseDetails").then((value) {
      if (value.isNotEmpty) {
        list = List<String>.from(json.decode(value)['getMidEnd']);
      } else {
        list = ["Mid", "End", "NA"];
      }
    });
    return list;
  }

  List<String> getVerification() {
    return [
      "Verified",
      "N/A",
    ];
  }

  Future<List<Description>> getCeiling() async {
    var list = [Description("", "")];
    await getPreference("buildingComponentOne").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getCeiling']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("RSI 10.43 (eff. 59.2) R 60 (nominal)", "0"),
          Description("R 70 (nominal)", ".1")
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getCathedralAndFlatRoof() async {
    var list = [Description("", "")];
    await getPreference("buildingComponentOne").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getCathedralAndFlatRoof']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("ALL Flat/Catherdral R40 (nominal)", ".1"),
          Description("ALL Flat/Catherdral R50 (nominal)", ".1"),
          Description("Cathedral R40", "0")
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getWallsAboveGrade() async {
    var list = [Description("", "")];
    await getPreference("buildingComponentOne").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getWallsAboveGrade']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("RSI 3.08 (R 17.5) R1.5+R22", "0"),
          Description("RSI 3.71 (R 21.1)", ".7"),
          Description("RSI 3.66 (R 20.8) R20+R5", "0"),
          Description("RSI 4.08 (R 23.2) R20+R6 (1.5in zip)", "0"),
          Description("RSI 3.79 (R 21.5) R22+R5 (siding)", ".7"),
          Description("RSI 3.96 (R 22.3) R22+R5 (all brick)", ".8"),
          Description("RSI 3.80 (R 21.6) R20+R5 (all brick)", ".7"),
          Description("RSI 3.90 (R 22.1) R24+R5 (siding)", ".7"),
          Description("RSI 4.10 (R23.3) R20+R7.5", "1.2"),
          Description("RSI 4.03 (R 22.9)", "1"),
          Description("RSI 4.35 (R 24.7)", "1.2"),
          Description("RSI 4.63 (R 26.3) R22+R10", "1.2"),
          Description("RSI 4.79 (R 27.2)", "1.5"),
          Description("RSI 5.09(R 28.9)", "1.6"),
          Description("RSI 3.75 (R 22.4) R22+R6", ".8"),
          Description("RSI 4.22 (R27.5) R22+R7.5", "1.5")
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getExposedFloor() async {
    var list = [Description("", "")];
    await getPreference("buildingComponentOne").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getExposedFloor']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("RSI 5.25 (R 29.8) R31", "0"),
          Description("RSI 6.16 (R 35) sprayfoam", "0"),
          Description("RSI 7.04 (R 40)", "0"),
          Description("RSI 7.04 (R 40) R24 Sprayfoam + R20 Batts", "0")
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getFoundationWall() async {
    var list = [Description("", "")];
    await getPreference("buildingComponentOne").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getFoundationWall']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("RSI 4.10 (R23.3) R20+R7.5", "0"),
          Description("RSI 4.19 (R 23.8)", ".1"),
          Description("RSI 4.22 (R 24) R5+R24@19.2 oc", ".1"),
          Description("RSI 4.45 (R 25.0)", ".2"),
          Description("RSI 4.67 (R 26) R10+R20", ".2"),
          Description("RSI 4.83 (R 27.4) R10+R22", ".2"),
          Description("RSI 5.13 (R 29.1)", ".3"),
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getUnheatedSlab() async {
    var list = [Description("", "")];
    await getPreference("buildingComponentOne").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getUnheatedSlab']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description(
              "Edge of Slab (600 mm (2ft)) RSI 1.74 (R10) w/thermal break",
              ".1"),
          Description(
              "Edge of Slab (600 mm (2ft)) RSI 2.64 (R15) w/thermal break",
              ".1"),
          Description("RSI 0.88 (R 5.0) full slab", ".1"),
          Description("RSI 1.32 (R 7.5) full slab", ".1"),
          Description("RSI 1.76 (R 10.0) full slab", ".2"),
          Description("RSI 2.64 (R 15.0) full slab", ".2"),
          Description("RSI 3.52 (R 20.0) full slab", ".2")
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getWindows() async {
    var list = [Description("", "")];
    await getPreference("buildingComponentTwo").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getWindows']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("ENERGY STAR Zone 2 UV1.4 / ER29", "0"),
          Description("ENERGY STAR Zone 3 UV1.2 / ER34 TRIPLE PANE", "0.5")
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getFireplace() async {
    var list = [Description("", "")];
    await getPreference("buildingComponentTwo").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getFireplace']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("Natural Gas spark ignition", "0"),
          Description("Natural Gas spark ignition/pilot (dual)", "0"),
          Description("Natural Gas pilot light (standing pilot)", "0"),
          Description("Natural Gas Intermittent pilot ignition", "0"),
          Description("Electric Fireplace installed", "0"),
          Description("Wood Stove - EPA", "0"),
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getElectricalSaving() async {
    var list = [Description("", "")];
    await getPreference("buildingComponentTwo").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getElectricalSaving']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("400 kWh/yr", "0.7"),
          Description("400+150=550 kWh/yr", "0.1"),
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getSpaceHeating() async {
    var list = [Description("", "")];
    await getPreference("buildingComponentThree").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getSpaceHeating']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("Ground-source heat pump", "0"),
          Description("Boiler 96%", "0"),
          Description("Air Source Heat Pump", "0"),
          Description("Water Source Heat Pump", "0"),
          Description("Ground Source Heat Pump", "0"),
          Description("Air Conditioner", "0"),
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getSpaceCooling() async {
    var list = [Description("", "")];
    await getPreference("buildingComponentThree").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getSpaceCooling']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("Air Source Heat Pump", "0"),
          Description("Water Source Heat Pump", "0"),
          Description("Ground Source Heat Pump", "0"),
          Description("Air Conditioner", "0")
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getDomesticHotWater() async {

    var list = [Description("", "")];
    await getPreference("buildingComponentThree").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getDomesticHotWater']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("Tank Condensing EF 0.80", "0"),
          Description("Instantaneous condensing min. EF 0.90", "0.3"),
          Description("Instantaneous condensing min. EF 0.95", "0.3"),
          Description("Instantaneous condensing min. EF 0.96", "0.3"),
          Description("Instantaneous condensing min. EF 0.97", "0.3"),
          Description("Instantaneous condensing min. EF 0.99", "0.3"),
          Description("Tank condensing min. TE 90% ", "0.1"),
          Description("Tank condensing min. TE 94% ", "0.2"),
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getDrainWaterHeatRecovery() async {

    var list = [Description("", "")];
    await getPreference("buildingComponentThree").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getDrainWaterHeatRecovery']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("≥42% two showers", "1.1"),
          Description("≥54% two DWHR units", "1.1"),
          Description("≥62% two showers", "1.3"),
          Description("≥62% two DWHR units", "1.3"),
          Description("≥70% one shower", "0.8"),
          Description("≥70% two showers", "1.5"),
          Description("≥70% two DWHR units", "1.5"),
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getAirTightness() async {
      var list = [Description("", "")];
    await getPreference("buildingComponentThree").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getAirTightness']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("Level 3 ATTACHED 0.15 nlr AND/OR 2.0 ACH", "0.7"),
          Description("Level 3 DETACHED 0.11 nlr AND/OR 1.5 ACH", "0.7"),
          Description("Level 4 ATTACHED 0.11 nlr AND/OR 1.5 ACH", "1.0"),
          Description("Level 4 DETACHED 0.07 nlr AND/OR 1.0 ACH", "1.0"),
          Description("Level 5 ATTACHED 0.05 nlr AND/OR 0.6 ACH", "1.0"),
          Description("Level 5 ATTACHED 0.05 nlr AND/OR 0.6 ACH", "1.0"),
        ];
      }
    });
    return list;
  }

  Future<List<Description>> getVentilation() async {
      var list = [Description("", "")];
    await getPreference("buildingComponentThree").then((value) {
      if (value.isNotEmpty) {
        list.clear();
        for (var ceiling in json.decode(value)['getVentilation']) {
          list.add(Description.fromJSON(ceiling));
        }
      } else {
        list = [
          Description("65% SRE @ 0 °C and 55% SRE @ -25 °C", "0"),
          Description("≥ 70% SRE @ 0 °C and 55% SRE @ -25 °C", "0.1"),
          Description("≥ 74% SRE @ 0 °C and 55% SRE @ -25 °C", "0.1"),
          Description(
              "ERV ≥ 67% SRE @ 0 °C and 60% SRE @ -25 °C (30/39watts)", "0"),
          Description("≥ 75% SRE @ 0 °C and 55% SRE @ -25 °C", "0.2"),
          Description("≥ 80% SRE @ 0 °C and 55% SRE @ -25 °C", "0.4"),
          Description("≥ 81% SRE @ 0 °C and 55% SRE @ -25 °C", "0.4"),
          Description("≥ 85% SRE @ 0 °C and 55% SRE @ -25 °C", "0.4"),
        ];
      }
    });
    return list;
  }
}
