import 'package:flutter/material.dart';
import 'package:picos/screens/overview_screen/progress.dart';

import 'input_card.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.green,
          child: const InputCard(),
        ),
        Container(
          color: Colors.lightGreen
        ),
        Container(
          color: Colors.blue,
          child: const Progress()
        )
      ]
    );
  }
}
