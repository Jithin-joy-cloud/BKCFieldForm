import 'package:bkc_field_form/models/device.dart';
import 'package:flutter/material.dart';

import '../models/descriprion.dart';

class DropDownCustom extends StatefulWidget {
  final List<Description> list;
  final ValueSetter<Description> callback;
  final String selectedItem;

  const DropDownCustom({
    Key? key,
    required this.list,
    required this.callback,
    required this.selectedItem,
  }) : super(key: key);

  @override
  DropDownCustomScreen createState() => DropDownCustomScreen();
}

class DropDownCustomScreen extends State<DropDownCustom> {
  String? selectedItem;
  final size = currentDevice.value.height;

  @override
  void initState() {
    selectedItem = widget.selectedItem.isEmpty
        ? widget.list.first.name
        : widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.list.isNotEmpty
    ?Container(
      height: size * .06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size * .03),
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size * .02),
        child: DropdownButton<String>(
            dropdownColor: Theme.of(context).cardColor,
            menuMaxHeight: size * .3,
            borderRadius: BorderRadius.circular(size * .01),
            value: selectedItem,
            elevation: 5,
            isExpanded: true,
            underline: const SizedBox(),
            items: widget.list
                .where((e) => e.value.isNotEmpty||  e.value.isNotEmpty!= null)
                .toSet()
                .map((item) => DropdownMenuItem<String>(
                      value: item.name,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          item.name,
                          style: TextStyle(
                              fontSize: size * .02,
                              color: Theme.of(context).canvasColor),
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (item) => {
                  setState(() {
                    selectedItem = item;
                    widget.callback(widget.list
                        .firstWhere((item) => item.name == selectedItem));
                  })
                }),
      ),
    ):SizedBox();
  }
}
