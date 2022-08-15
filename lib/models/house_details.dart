import 'package:objectbox/objectbox.dart';

@Entity()
class House {
  int id = 0;
  String site = "";
  int? phase;
  int? lot;
  String address = "";
  String city = "";
  String postalCode = "";
  String province = "";
  String att_det_murb = "";
  String mid_end_ = "";
  String direction = "";
  String specialCondition = "";
  String modelName = "";
  double? volume;
  double? surfaceArea;
  String comments = "";

  House();

  House.fromJSON(Map<String, dynamic> jsonMap) {
    if (jsonMap.isNotEmpty) {
      site = jsonMap['site'];
      lot = int.parse(jsonMap['lot']);
      phase = int.parse(jsonMap['phase']);
      address = jsonMap['address'];
      city = jsonMap['city'];
      postalCode = jsonMap['postalCode'].toString();
      province = jsonMap['province'];
      att_det_murb = jsonMap['att_det_murb'];
      mid_end_ = jsonMap['mid_end_'];
      direction = jsonMap['direction'];
      specialCondition = jsonMap['specialCondition'];
       modelName = jsonMap['modelName'];
      volume =
          jsonMap['volume'] == 'null' ? 0 : double.parse(jsonMap['volume']);
      surfaceArea = jsonMap['surfaceArea'] == "null"
          ? 0
          : double.parse(jsonMap['surfaceArea']);
    }
  }

  House.fromJSONExcel(Map<String, dynamic> jsonMap) {
    if (jsonMap.isNotEmpty) {
      site = jsonMap['Site:']?? "";
      lot = jsonMap['Phase:'];
      phase = jsonMap['Lot:'];
      address = jsonMap['Address:']?? "";
      city = jsonMap['City:']?? "";
      postalCode = jsonMap['Postal Code:']?? "";
      province = jsonMap['Province:']?? "";
      att_det_murb = jsonMap['Att./Detached/Murb:']?? "";
      mid_end_ = jsonMap['Mid/End:']?? "";
      direction = jsonMap['Direction:']?? "";
      specialCondition = jsonMap['Special Condition:']?? "";
      modelName = jsonMap['Model Name:']?? "";
      volume = jsonMap['Volume:'].toString().contains("Formula")
          ? null
          : jsonMap['Volume:'];
      surfaceArea = jsonMap['Surface Area:'].toString().contains("")
          ? null
          : jsonMap['Surface Area:'];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'houseId': id.toString(),
      'site': site.toString(),
      'lot': lot.toString(),
      'phase': phase.toString(),
      'address': address.toString(),
      'city': city.toString(),
      'postalCode': postalCode.toString(),
      'province': province.toString(),
      'att_det_murb': att_det_murb.toString(),
      'mid_end_': mid_end_.toString(),
      'direction': direction.toString(),
      'specialCondition': specialCondition.toString(),
      'modelName': modelName.toString(),
      'volume': volume.toString(),
      'surfaceArea': surfaceArea.toString(),
    };
  }

  String? validateHouse() {
    if (site.length < 2 || site.length > 24) {
      return "Please enter a valid site";
    }
    if (lot == null) {
      return "Please enter a valid lot";
    }
    if (phase == null) {
      return "Please enter a valid phase";
    }
    if (address.length < 2) {
      return "Please enter a valid address";
    }
    if (city.length < 2) {
      return "Please enter a valid city";
    }
    if (postalCode.length > 8) {
      return "Please enter a valid postalCode";
    }
    if (province.length < 2 || province.length > 16) {
      return "Please enter a valid province";
    }
    return null;
  }
}
