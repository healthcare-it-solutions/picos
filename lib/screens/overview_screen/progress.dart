import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Progress extends StatelessWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("lorem ipsum dolor sit amet"),
                SizedBox(height: 20),
                ElevatedButton(onPressed: null, child: Text("PLACEHOLDER"))
              ],
            ),
            Text(
              "75 %",
              textScaleFactor: 5,
            )
          ],
        ));
  }
}
