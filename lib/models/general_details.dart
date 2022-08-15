import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class General {
  int id = 0;
  String enrolmentId = "";
  String alt_file_id = "";
  String chba_nz_file = "";
  String perspective = "";
  String soName = "";
  String hddZone = "";
  String builderName = "";
  int? builderId;
  String evaluatorName = "";
  int? evaluatorId;
  String fieldTechnician = "";
  String inspectionDate = "";
  String siteContactName = "";
  String siteContactNumber = "";
  String siteContactEmail = "";

  General();

  General.fromJSON(Map<String, dynamic> jsonMap) {
    if (jsonMap.isNotEmpty) {
      enrolmentId = jsonMap['enrolmentId'].toString();
      alt_file_id = jsonMap['alt_file_id'];
      chba_nz_file = jsonMap['chba_nz_file'];
      perspective = jsonMap['perspective'].toString();
      soName = jsonMap['soName'].toString();
      hddZone = jsonMap['hddZone'].toString();
      builderName = jsonMap['builderName'];
      // builderId = jsonMap['builderId']!=null?int.parse(jsonMap['builderId']):0;
      builderId =
          jsonMap['builderId'] != "null" ? int.parse(jsonMap['builderId']) : null;
      evaluatorName = jsonMap['evaluatorName'];
      evaluatorId = jsonMap['evaluatorId'] != "null"
          ? int.parse(jsonMap['evaluatorId'])
          : null;
      fieldTechnician = jsonMap['fieldTechnician'];
      inspectionDate = jsonMap['inspectionDate'];
      siteContactName = jsonMap['siteContactName'];
      siteContactNumber = jsonMap['siteContactNumber'];
      siteContactEmail = jsonMap['siteContactEmail'];
    }
  }

  General.fromJSONExcel(Map<String, dynamic> jsonMap) {
    if (jsonMap.isNotEmpty) {
      enrolmentId = jsonMap['EsEnrolment ID:'] ?? "";
      alt_file_id = jsonMap['Alternative File ID:'] ?? "";
      chba_nz_file = jsonMap['CHBA NZ File #:'] ?? "";
      perspective = jsonMap['Prescriptive or Performance:'] ?? "";
      soName = jsonMap['SO Name and #, HDD Zone:'] ?? "";
      hddZone = jsonMap['SO Name and #, HDD Zone:'] ?? "";
      builderName = jsonMap['Builder Name:'] ?? "";
      //builderId = int.parse(jsonMap['Builder ID:']);
      evaluatorName = jsonMap['Evalulator Name:'] ?? "";
      evaluatorId = jsonMap['Evaluator Number:'].toString().contains("Formula")
          ? null
          : jsonMap['Evaluator Number:'];
      fieldTechnician = jsonMap['Field Technician:'] ?? "";
      // inspectionDate = jsonMap['Inspection Date:'];
      siteContactName = jsonMap['Site Contact Name:'] ?? "";
      siteContactNumber = jsonMap['Site Contact Phone:'] ?? "";
      siteContactEmail = jsonMap['Site Contact Email:'] ?? "";
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'generalId': id.toString(),
      'enrolmentId': enrolmentId.toString(),
      'alt_file_id': alt_file_id.toString(),
      'chba_nz_file': chba_nz_file.toString(),
      'perspective': perspective.toString(),
      'soName': soName.toString(),
      'hddZone': hddZone.toString(),
      'builderName': builderName.toString(),
      'builderId': builderId.toString(),
      'evaluatorName': evaluatorName.toString(),
      'evaluatorId': evaluatorId.toString(),
      'fieldTechnician': fieldTechnician.toString(),
      'inspectionDate': inspectionDate.toString(),
      'siteContactName': siteContactName.toString(),
      'siteContactNumber': siteContactNumber.toString(),
      'siteContactEmail': siteContactEmail.toString(),
    };
  }

  bool _isNumeric(dynamic str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  String? validateGeneral() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(siteContactEmail);
    bool phoneValid = RegExp(r"^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$")
        .hasMatch(siteContactNumber);

    if (enrolmentId.length < 2 || enrolmentId.length > 16) {
      return "Please enter a valid enrolmentId";
    }
    if (evaluatorName.length < 2 || evaluatorName.length > 16) {
      return "Please enter a valid evaluator Name";
    }
    if (evaluatorId.toString().length != 4) {
      return "Please enter a valid evaluator number";
    }
    if (builderName.length < 2 || builderName.length > 24) {
      return "Please enter a valid builder name";
    }

    if (inspectionDate.isEmpty) {
      return "Please enter a valid date";
    }
    if (siteContactName.length < 2 || siteContactName.length > 24) {
      return "Please enter a valid site contact name";
    }
    if (!phoneValid) {
      return "Please enter a valid site phone number";
    }
    if (!emailValid) {
      return "Please enter a valid site email";
    }
    return null;
  }
}
