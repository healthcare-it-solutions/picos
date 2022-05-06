import 'package:flutter/material.dart';

///A pre configured selection widget.
class PicosSelect extends StatefulWidget {
  ///Creates a select-dropdown-item.
  const PicosSelect(
      {required this.selection,
      required this.callBackFunction,
      Key? key,
      this.hint})
      : super(key: key);

  ///The array of items selectable in the dropdown.
  final List<String> selection;

  ///The function that is executed when an item gets selected.
  final Function(String) callBackFunction;

  ///The hint shown in the select.
  final String? hint;

  @override
  _PicosSelectState createState() => _PicosSelectState();
}

class _PicosSelectState extends State<PicosSelect> {
  String? _dropdownValue;

  List<DropdownMenuItem<String>> _createCompoundList() {
    return widget.selection
        .map<DropdownMenuItem<String>>(
          (String e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(7);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: Colors.grey.shade400,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              borderRadius: borderRadius,
              value: _dropdownValue,
              iconSize: 30,
              icon: const Icon(Icons.keyboard_arrow_down),
              hint: Text(widget.hint ?? ''),
              onChanged: (String? newValue) {
                setState(() {
                  final String value = newValue ?? '';

                  widget.callBackFunction(value);
                  _dropdownValue = value;
                });
              },
              items: _createCompoundList(),
            ),
          ),
        ),
      ),
    );
  }
}
