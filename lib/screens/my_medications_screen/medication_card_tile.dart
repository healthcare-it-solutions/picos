import 'package:flutter/material.dart';

///Each quarter of the medication card showing when and how much medicine you
///have to take.
class MedicationCardTile extends StatelessWidget {
  ///MedicationCardTile(Time:[String], Amount:[String])
  const MedicationCardTile(this._time, this._amount, {Key? key})
      : super(key: key);

  final String _time;
  final String _amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(_time),
        const Spacer(),
        SizedBox(
          width: 25,
          child: Center(
            child: Text(_amount),
          ),
        ),
      ],
    );
  }
}
