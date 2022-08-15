import 'package:bkc_field_form/models/device.dart';
import 'package:flutter/material.dart';

class RadioGroupCustom extends StatefulWidget {
  final List<String> list;
  final String selectedItem;
  final ValueSetter<String> callback;
  final bool isBG;

  const RadioGroupCustom({
    Key? key,
    required this.list,
    required this.callback,
    required this.selectedItem,
    required this.isBG,
  }) : super(key: key);

  @override
  RadioGroupCustomScreen createState() => RadioGroupCustomScreen();
}

class RadioGroupCustomScreen extends State<RadioGroupCustom> {
  late String selectedValue;
  final width = currentDevice.value.width;
  final height = currentDevice.value.height;

  @override
  void initState() {
    selectedValue =
        widget.selectedItem.isEmpty ? widget.list.first : widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.isBG
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(height * .03),
              color: Theme.of(context).cardColor,
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2))
          : null,
      child: Wrap(
        children: widget.list
            .map((value) => SizedBox(
                  width: width * .45,
                  child: ListTileTheme(
                    dense: true,
                    horizontalTitleGap: widget.isBG ? 10 : -5,
                    minVerticalPadding: widget.isBG ? 10 : -5,
                    child: RadioListTile<String>(
                        value: value,
                        contentPadding: const EdgeInsets.all(0),
                        dense: true,
                        groupValue: selectedValue,
                        activeColor: Theme.of(context).primaryColor,
                        title: Text(
                          value,
                          style: TextStyle(
                            fontSize: widget.isBG ? height * .02 : height * .02,
                          ),
                        ),
                        onChanged: (value) => setState(() {
                              selectedValue = value!;
                              widget.callback(selectedValue);
                            })),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
