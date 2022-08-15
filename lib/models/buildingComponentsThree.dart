import 'package:objectbox/objectbox.dart';

@Entity()
class BuildComponentThree {
  int id = 0;
  String airTightnessBOPDescription = "";
  String airTightnessVerification = "N/A";
  String airTightnessCredit = "";
  String airTightnessACH = "";
  String airTightnessNLR = "";
  String airTightnessEQLA = "";
  String drainWaterBOPDescription = "";
  String drainWaterVerification = "N/A";
  String drainWaterCredit = "";
  String drainWaterMake = "";
  String drainWaterModel = "";
  String drainWaterImage = "";
  String spaceCoolingBOPDescription = "";
  String spaceCoolingVerification = "N/A";
  String spaceCoolingCredit = "";
  String spaceCoolingMake = "";
  String spaceCoolingModel = "";
  String spaceCoolingImage = "";
  String spaceHeatingBOPDescription = "";
  String spaceHeatingVerification = "N/A";
  String spaceHeatingCredit = "";
  String spaceHeatingMake = "";
  String spaceHeatingModel = "";
  String spaceHeatingImage = "";
  String ductSealingRequired = "";
  String ductSealingVerification = "N/A";
  String domesticHotWaterBOPDescription = "";
  String domesticHotWaterVerification = "N/A";
  String domesticHotWaterCredit = "";
  String domesticHotWaterMake = "";
  String domesticHotWaterModel = "";
  String domesticHotWaterImage = "";
  String ventilationBOPDescription = "";
  String ventilationVerification = "N/A";
  String ventilationCredit = "";
  String ventilationMake = "";
  String ventilationModel = "";
  String ventilationImage = "";
  String ventilationFresh = "";
  String ventilationStale = "";
  int bedroomCount = 0;
  String furnaceFan = "";
  String hrvBalanced = "";
  String comments = "";

  BuildComponentThree();

  Map<String, dynamic> toMap() {
    return {
      'buildingComponentThreeId': id.toString(),
      'airTightnessBOPDescription': airTightnessBOPDescription.toString(),
      'airTightnessVerification': airTightnessVerification.toString(),
      'airTightnessCredit': airTightnessCredit.toString(),
      'airTightnessACH': airTightnessACH.toString(),
      'airTightnessNLR': airTightnessNLR.toString(),
      'airTightnessEQLA': airTightnessEQLA.toString(),
      'drainWaterBOPDescription': drainWaterBOPDescription.toString(),
      'drainWaterVerification': drainWaterVerification.toString(),
      'drainWaterCredit': drainWaterCredit.toString(),
      'drainWaterMake': drainWaterMake.toString(),
      'drainWaterModel': drainWaterModel.toString(),
      'drainWaterImage': drainWaterImage.toString(),
      'spaceCoolingBOPDescription': spaceCoolingBOPDescription.toString(),
      'spaceCoolingVerification': spaceCoolingVerification.toString(),
      'spaceCoolingCredit': spaceCoolingCredit.toString(),
      'spaceCoolingMake': spaceCoolingMake.toString(),
      'spaceCoolingModel': spaceCoolingModel.toString(),
      'spaceCoolingImage': spaceCoolingImage.toString(),
      'spaceHeatingBOPDescription': spaceHeatingBOPDescription.toString(),
      'spaceHeatingVerification': spaceHeatingVerification.toString(),
      'spaceHeatingCredit': spaceHeatingCredit.toString(),
      'spaceHeatingMake': spaceHeatingMake.toString(),
      'spaceHeatingModel': spaceHeatingModel.toString(),
      'spaceHeatingImage': spaceHeatingImage.toString(),
      'ductSealingRequired': ductSealingRequired.toString(),
      'ductSealingVerification': ductSealingVerification.toString(),
      'domesticHotWaterBOPDescription': domesticHotWaterBOPDescription.toString(),
      'domesticHotWaterVerification': domesticHotWaterVerification.toString(),
      'domesticHotWaterCredit': domesticHotWaterCredit.toString(),
      'domesticHotWaterMake': domesticHotWaterMake.toString(),
      'domesticHotWaterModel': domesticHotWaterModel.toString(),
      'domesticHotWaterImage': domesticHotWaterImage.toString(),
      'ventilationBOPDescription': ventilationBOPDescription.toString(),
      'ventilationVerification': ventilationVerification.toString(),
      'ventilationCredit': ventilationCredit.toString(),
      'ventilationMake': ventilationMake.toString(),
      'ventilationModel': ventilationModel.toString(),
      'ventilationImage': ventilationImage.toString(),
      'ventilationStale': ventilationStale.toString(),
      'ventilationFresh': ventilationFresh.toString(),
      'bedroomCount': bedroomCount.toString(),
      'furnaceFan': furnaceFan.toString(),
      'hrvBalanced': hrvBalanced.toString(),
      'buildingComponentThreeComments': comments,
    };
  }

  BuildComponentThree.fromJSON(Map<String, dynamic> jsonMap) {
    if (jsonMap.isNotEmpty) {
      airTightnessBOPDescription = jsonMap['airTightnessBOPDescription'];
      airTightnessVerification = jsonMap['airTightnessVerification'];
      airTightnessACH = jsonMap['airTightnessACH'];
      airTightnessNLR = jsonMap['airTightnessNLR'];
      airTightnessEQLA = jsonMap['airTightnessEQLA'];
      airTightnessCredit = jsonMap['airTightnessCredit'];
      spaceHeatingBOPDescription = jsonMap['spaceHeatingBOPDescription'];
      spaceHeatingVerification = jsonMap['spaceHeatingVerification'];
      spaceHeatingCredit = jsonMap['spaceHeatingCredit'];
      spaceHeatingMake = jsonMap['spaceHeatingMake'];
      spaceHeatingModel = jsonMap['spaceHeatingModel'];
      spaceHeatingImage = jsonMap['spaceHeatingImage'];
      spaceCoolingBOPDescription = jsonMap['spaceCoolingBOPDescription'];
      spaceCoolingVerification = jsonMap['spaceCoolingVerification'];
      spaceCoolingCredit = jsonMap['spaceCoolingCredit'];
      spaceCoolingMake = jsonMap['spaceCoolingMake'];
      spaceCoolingModel = jsonMap['spaceCoolingModel'];
      spaceCoolingImage = jsonMap['spaceCoolingImage'];
      drainWaterBOPDescription = jsonMap['drainWaterBOPDescription'];
      drainWaterVerification = jsonMap['drainWaterVerification'];
      drainWaterCredit = jsonMap['drainWaterCredit'];
      drainWaterMake = jsonMap['drainWaterMake'];
      drainWaterModel = jsonMap['drainWaterModel'];
      drainWaterImage = jsonMap['drainWaterImage'];
      ductSealingRequired = jsonMap['ductSealingRequired'];
      ductSealingVerification = jsonMap['ductSealingVerification'];
      domesticHotWaterBOPDescription =
          jsonMap['domesticHotWaterBOPDescription'];
      domesticHotWaterVerification = jsonMap['domesticHotWaterVerification'];
      domesticHotWaterCredit = jsonMap['domesticHotWaterCredit'];
      domesticHotWaterMake = jsonMap['domesticHotWaterMake'];
      domesticHotWaterModel = jsonMap['domesticHotWaterModel'];
      domesticHotWaterImage = jsonMap['domesticHotWaterImage'];
      ventilationBOPDescription = jsonMap['ventilationBOPDescription'];
      ventilationVerification = jsonMap['ventilationVerification'];
      ventilationCredit = jsonMap['ventilationCredit'];
      ventilationImage = jsonMap['ventilationImage'];
      ventilationMake = jsonMap['ventilationMake'];
      ventilationModel = jsonMap['ventilationModel'];
      ventilationFresh = jsonMap['ventilationFresh'];
      ventilationStale = jsonMap['ventilationStale'];
      bedroomCount = int.parse(jsonMap['bedroomCount']);
      furnaceFan = jsonMap['furnaceFan'];
      hrvBalanced = jsonMap['hrvBalanced'];
      comments = jsonMap['buildingComponentThreeComments'];
    }
  }
}
