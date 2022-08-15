class Description {
  String name = "";
  String value = "";

  Description(this.name, this.value);

  Description.fromJSON(Map<String, dynamic> jsonMap) {
    if (jsonMap.isNotEmpty) {
      name = jsonMap.keys.first;
      value =jsonMap.values.first;
    }
  }
}
