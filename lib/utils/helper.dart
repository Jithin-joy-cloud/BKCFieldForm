import 'dart:io';
import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:bkc_field_form/models/descriprion.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/general_details.dart';
import '../models/house_details.dart';

class Helper {
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static String getDocumentString(String input, String replace) {
    return input.replaceAll(RegExp(replace), "");
  }

 static Future<double> calculateCredit(FormController formController) async {
    double sum = 0;
    sum += double.parse(formController.buildComponentOne.cbaBOPCredit);
    sum += double.parse(formController.buildComponentOne.fwBOPCredit);
    sum += double.parse(formController.buildComponentOne.cfrBOPCredit);
    sum += double.parse(formController.buildComponentOne.wagBOPCredit);
    sum += double.parse(formController.buildComponentOne.efBOPCredit);
    sum += double.parse(formController.buildComponentOne.uhbBOPCredit);

    sum += double.parse(formController.buildComponentTwo.esBOPCredit);
    sum += double.parse(formController.buildComponentTwo.fireplaceCredit);
    sum += double.parse(formController.buildComponentTwo.windowBOPCredit);

    sum += double.parse(formController.buildComponentThree.spaceHeatingCredit);
    sum += double.parse(formController.buildComponentThree.spaceCoolingCredit);
    sum += double.parse(formController.buildComponentThree.airTightnessCredit);
    sum += double.parse(formController.buildComponentThree.ventilationCredit);
    sum += double.parse(formController.buildComponentThree.drainWaterCredit);
    sum +=
        double.parse(formController.buildComponentThree.domesticHotWaterCredit);
    return sum;
  }

  static Future<dynamic> pickFile() async {
    late General general;
    late House house;
    FilePickerResult? file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['xlsx', 'csv', 'xls']);
    if (file != null && file.files.isNotEmpty) {
      var bytes = File(file.files.first.path!).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      Map<String, dynamic> generalMap = {};
      Map<String, dynamic> houseMap = {};
      for (int rowIndex = 1; rowIndex < 15; rowIndex++) {
        Sheet sheetObject = excel['Inspection Form'];

        generalMap[
            sheetObject
                .cell(CellIndex.indexByColumnRow(
                    columnIndex: 0, rowIndex: rowIndex))
                .value
                .toString()] = sheetObject
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex))
            .value;

        houseMap[
            sheetObject
                .cell(CellIndex.indexByColumnRow(
                    columnIndex: 2, rowIndex: rowIndex))
                .value
                .toString()] = sheetObject
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex))
            .value;
      }
      general = General.fromJSONExcel(generalMap);
      house = House.fromJSONExcel(houseMap);
      return [general, house];
    } else {
      return null;
    }
  }

  static String getMonth(int month) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
