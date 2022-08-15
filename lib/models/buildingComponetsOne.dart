import 'package:objectbox/objectbox.dart';

@Entity()
class BuildComponentOne {
  int id = 0;
  String wagBOPDescription = "";
  String wagBOPCredit = "";
  String wagVerification = "N/A";
  String cfrBOPDescription = "";
  String cfrBOPCredit = "";
  String cfrVerification = "N/A";
  String cbaBOPDescription = "";
  String cbaBOPCredit = "";
  String cbaVerification = "N/A";
  String efBOPDescription = "";
  String efBOPCredit = "";
  String efVerification = "N/A";
  String fwBOPDescription = "";
  String fwBOPCredit = "";
  String fwVerification = "N/A";
  String fwImage = "";
  String uhbBOPDescription = "";
  String uhbBOPCredit = "";
  String uhbVerification = "N/A";
  String comments = "";

  BuildComponentOne();

  BuildComponentOne.fromJSON(Map<String, dynamic> jsonMap) {
    if (jsonMap.isNotEmpty) {
      wagBOPDescription = jsonMap['wagBOPDescription'];
      wagBOPCredit = jsonMap['wagBOPCredit'];
      wagVerification = jsonMap['wagVerification'];
      cfrBOPDescription = jsonMap['cfrBOPDescription'];
      cfrBOPCredit = jsonMap['cfrBOPCredit'];
      cfrVerification = jsonMap['cfrVerification'];
      cbaBOPDescription = jsonMap['cbaBOPDescription'];
      cbaBOPCredit = jsonMap['cbaBOPCredit'];
      cbaVerification = jsonMap['cbaVerification'];
      efBOPDescription = jsonMap['efBOPDescription'];
      efBOPCredit = jsonMap['efBOPCredit'];
      efVerification = jsonMap['efVerification'];
      fwBOPDescription = jsonMap['fwBOPDescription'];
      fwBOPCredit = jsonMap['fwBOPCredit'];
      fwVerification = jsonMap['fwVerification'];
      fwImage = jsonMap['fwImage'];
      uhbBOPDescription = jsonMap['uhbBOPDescription'];
      uhbBOPCredit = jsonMap['uhbBOPCredit'];
      uhbVerification = jsonMap['uhbVerification'];
      comments = jsonMap['buildingComponentOneComments'];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'buildingComponentOneId': id.toString(),
      'wagBOPDescription': wagBOPDescription.toString(),
      'wagBOPCredit': wagBOPCredit.toString(),
      'wagVerification': wagVerification.toString(),
      'cfrBOPDescription': cfrBOPDescription.toString(),
      'cfrBOPCredit': cfrBOPCredit.toString(),
      'cfrVerification': cfrVerification.toString(),
      'cbaBOPDescription': cbaBOPDescription.toString(),
      'cbaBOPCredit': cbaBOPCredit.toString(),
      'cbaVerification': cbaVerification.toString(),
      'efBOPDescription': efBOPDescription.toString(),
      'efBOPCredit': efBOPCredit.toString(),
      'efVerification': efVerification.toString(),
      'fwBOPDescription': fwBOPDescription.toString(),
      'fwBOPCredit': fwBOPCredit.toString(),
      'fwVerification': fwVerification.toString(),
      'fwImage': fwImage.toString(),
      'uhbBOPDescription': uhbBOPDescription.toString(),
      'uhbBOPCredit': uhbBOPCredit.toString(),
      'uhbVerification': uhbVerification.toString(),
      'buildingComponentOneComments': comments.toString(),
    };
  }
}
