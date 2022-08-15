import 'dart:io';

import 'package:bkc_field_form/models/buildingComponentsThree.dart';
import 'package:bkc_field_form/models/buildingComponentsTwo.dart';
import 'package:bkc_field_form/models/buildingComponetsOne.dart';
import 'package:bkc_field_form/models/completeForm.dart';
import 'package:bkc_field_form/models/general_details.dart';
import 'package:bkc_field_form/models/house_details.dart';
import 'package:path_provider/path_provider.dart';
import '../objectbox.g.dart';

class FormObjectBox {
  late final Store _store;
  late final Box<CompleteForm> _userBox;

  FormObjectBox._init(this._store) {
    _userBox = Box<CompleteForm>(_store);
  }

  static Future<FormObjectBox> init() async {
    final store = await openStore();

    return FormObjectBox._init(store);
  }

  CompleteForm? getFormWithID(int id) => _userBox.get(id);

  Stream<List<CompleteForm>> getAllForm() {
    return _userBox
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  Future<List<General>?> getGeneralDetails() async {
    List<General>? generalList;
    generalList = [General()];
    generalList.clear();
    _userBox.getAll().forEach((element) {
      generalList!.add(element.general.target!);
    });
    return generalList;
  }
  Future<List<House>?> getHouseDetails() async {
    List<House>? houseList;
    houseList = [House()];
    houseList.clear();
    _userBox.getAll().forEach((element) {
      houseList!.add(element.house.target!);
    });
    return houseList;
  }

  Future<int> createForm(CompleteForm form) async {
    return _userBox.put(form);
  }

  Future<void> updateForm(CompleteForm form) async {
    final general = form.general.target;
    final house = form.house.target;
    final b1 = form.buildComponentOne.target;
    final b2 = form.buildComponentTwo.target;
    final b3 = form.buildComponentThree.target;
    _store.box<General>().put(general!);
    _store.box<House>().put(house!);
    _store.box<BuildComponentOne>().put(b1!);
    _store.box<BuildComponentTwo>().put(b2!);
    _store.box<BuildComponentThree>().put(b3!);
  }

  Future<int> deleteForm() async {
    return _userBox.removeAll();
  }

  bool deleteFormWithId(int id) => _userBox.remove(id);
}
