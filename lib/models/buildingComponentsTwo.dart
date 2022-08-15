import 'package:objectbox/objectbox.dart';

@Entity()
class BuildComponentTwo {
  int id = 0;
  String insulatedDoorRequired = "";
  String insulatedDoorVerification = "N/A";
  String cellarDoorRequired = "";
  String cellarDoorVerification = "N/A";
  String fireplaceBOPDescription = "";
  String fireplaceVerification = "N/A";
  String fireplaceCredit = "";
  String fireplaceMake = "";
  String fireplaceModel = "";
  String fireplaceImage = "";
  String triplesBOPDescription = "";
  String triplesVerification = "N/A";
  String esBOPDescription = "";
  String esBOPCredit = "";
  String esVerification = "N/A";
  String energyMonitorRequired = "";
  String energyMonitorVerification = "N/A";
  String solarPVRequired = "";
  String solarPVVerification = "N/A";
  String windowBOPDescription = "";
  String windowBOPCredit = "";
  String windowVerification = "N/A";
  String windowImage = "";
  String windowMake = "";
  String comments = "";

  BuildComponentTwo();

  BuildComponentTwo.fromJSON(Map<String, dynamic> jsonMap) {
    if (jsonMap.isNotEmpty) {
      windowBOPDescription = jsonMap['windowBOPDescription'];
      windowBOPCredit = jsonMap['windowBOPCredit'];
      windowVerification = jsonMap['windowVerification'];
      windowImage = jsonMap['windowImage'];
      windowMake = jsonMap['windowMake'];
      fireplaceBOPDescription = jsonMap['fireplaceBOPDescription'];
      fireplaceVerification = jsonMap['fireplaceVerification'];
      fireplaceCredit = jsonMap['fireplaceCredit'];
      fireplaceMake = jsonMap['fireplaceMake'];
      fireplaceModel = jsonMap['fireplaceModel'];
      fireplaceImage = jsonMap['fireplaceImage'];
      triplesBOPDescription = jsonMap['triplesBOPDescription'];
      triplesVerification = jsonMap['triplesVerification'];
      insulatedDoorRequired = jsonMap['insulatedDoorRequired'];
      insulatedDoorVerification = jsonMap['insulatedDoorVerification'];
      cellarDoorRequired = jsonMap['cellarDoorRequired'];
      cellarDoorVerification = jsonMap['cellarDoorVerification'];
      esBOPDescription = jsonMap['esBOPDescription'];
      esBOPCredit = jsonMap['esBOPCredit'];
      esVerification = jsonMap['esVerification'];
      energyMonitorRequired = jsonMap['energyMonitorRequired'];
      energyMonitorVerification = jsonMap['energyMonitorVerification'];
      solarPVRequired = jsonMap['solarPVRequired'];
      solarPVVerification = jsonMap['solarPVVerification'];
      comments = jsonMap['buildingComponentTwoComments'];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'buildingComponentTwoId': id.toString(),
      'windowBOPDescription': windowBOPDescription.toString(),
      'windowBOPCredit': windowBOPCredit.toString(),
      'windowVerification': windowVerification.toString(),
      'windowImage': windowImage.toString(),
      'windowMake': windowMake.toString(),
      'fireplaceBOPDescription': fireplaceBOPDescription.toString(),
      'fireplaceVerification': fireplaceVerification.toString(),
      'fireplaceCredit': fireplaceCredit.toString(),
      'fireplaceMake': fireplaceMake.toString(),
      'fireplaceModel': fireplaceModel.toString(),
      'fireplaceImage': fireplaceImage.toString(),
      'triplesBOPDescription': triplesBOPDescription.toString(),
      'triplesVerification': triplesVerification.toString(),
      'insulatedDoorRequired': insulatedDoorRequired.toString(),
      'insulatedDoorVerification': insulatedDoorVerification.toString(),
      'cellarDoorRequired': cellarDoorRequired.toString(),
      'cellarDoorVerification': cellarDoorVerification.toString(),
      'esBOPDescription': esBOPDescription.toString(),
      'esBOPCredit': esBOPCredit.toString(),
      'esVerification': esVerification.toString(),
      'energyMonitorRequired': energyMonitorRequired.toString(),
      'energyMonitorVerification': energyMonitorVerification.toString(),
      'solarPVRequired': solarPVRequired.toString(),
      'solarPVVerification': solarPVVerification.toString(),
      'buildingComponentTwoComments': comments.toString(),
    };
  }
}
