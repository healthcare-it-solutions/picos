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
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
                Row(children: const <Widget> [Text('PLACEHOLDER')]),
                // Ok, this is a horizontal line, if there are better solutions
                // to this, be my guest to refactor this.
                Container(
                  color: Colors.black,
                  constraints: const BoxConstraints(maxHeight: 1, minWidth: 10)
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 10)
                ),
                MiniCalendar(),
                const SizedBox(height: 20),
                const ElevatedButton(
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
