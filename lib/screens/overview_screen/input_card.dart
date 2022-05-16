import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:picos/screens/overview_screen/mini_calendar.dart';

/// This class implements the top section of the 'overview'.
class InputCard extends StatelessWidget {
  const InputCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      //heightFactor: 1,
      child: Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                Row(children: [Text("PLACEHOLDER")]),
                // Ok, this is a horizontal line, if there are better solutions
                // to this, be my guest to refactor this.
                Container(
                  color: Colors.black,
                  constraints: BoxConstraints(maxHeight: 1, minWidth: 10)
                ),
                ConstrainedBox(constraints: BoxConstraints(minHeight: 10)),
                MiniCalendar(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: null,
                  child: Text('PLACEHOLDER'),
                )
              ]
            )
        )
      )
    );
    
    
  }
}
