import 'package:bkc_field_form/models/buildingComponentsThree.dart';
import 'package:bkc_field_form/models/buildingComponentsTwo.dart';
import 'package:bkc_field_form/models/buildingComponetsOne.dart';
import 'package:bkc_field_form/models/general_details.dart';
import 'package:bkc_field_form/models/house_details.dart';
import 'package:bkc_field_form/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

import '../repository/user_repository.dart';

@Entity()
class CompleteForm {
  int id = 0;
  var general = ToOne<General>();
  var house = ToOne<House>();
  var buildComponentOne = ToOne<BuildComponentOne>();
  var buildComponentTwo = ToOne<BuildComponentTwo>();
  var buildComponentThree = ToOne<BuildComponentThree>();

  CompleteForm.fromJSON(Map<String, dynamic> jsonMap) {
    if (jsonMap.isNotEmpty) {
      general.target = General.fromJSON(jsonMap['general']);
      house.target = House.fromJSON(jsonMap['house']);
      buildComponentOne.target =
          BuildComponentOne.fromJSON(jsonMap['buildingComponentOne']);
      buildComponentTwo.target =
          BuildComponentTwo.fromJSON(jsonMap['buildingComponentTwo']);
      buildComponentThree.target =
          BuildComponentThree.fromJSON(jsonMap['buildingComponentThree']);
    }
  }

  Map<String, dynamic> toMap(
      int idForm,
      Map<dynamic, dynamic> gl,
      Map<dynamic, dynamic> h,
      Map<dynamic, dynamic> b1,
      Map<dynamic, dynamic> b2,
      Map<dynamic, dynamic> b3) {
    return {
      'completeFormId': idForm,
      "email": currentUser.value.email,
      "evaluatorId": currentUser.value.employeeID,
      'general': gl,
      'house': h,
      'buildComponentOne': b1,
      'buildComponentTwo': b2,
      'buildComponentThree': b3,
    };
  }

  CompleteForm();
}
