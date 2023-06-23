import 'package:flutter/material.dart';

/// Creates a switch for [bool] values;
class PicosSwitch extends StatefulWidget {
  /// Creates a PicosSwitch.
  const PicosSwitch({
    required this.callbackFunction,
    Key? key,
    this.initialValue,
    this.title,
    this.shape,
  }) : super(key: key);

  /// The initial value.
  final bool? initialValue;

  /// The function to be called on changing values.
  final void Function(bool value) callbackFunction;

  /// Switch title.
  final String? title;

  /// Switch shape.
  final ShapeBorder? shape;

  @override
  State<PicosSwitch> createState() => _PicosSwitchState();
}

class _PicosSwitchState extends State<PicosSwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      _value = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _value,
      onChanged: (bool value) {
        setState(() {
          _value = value;
        });

        widget.callbackFunction(value);
      },
      title: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(
          widget.title ?? '',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      shape: widget.shape,
    );
  }
}
