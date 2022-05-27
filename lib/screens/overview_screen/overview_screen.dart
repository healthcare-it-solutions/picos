import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:picos/screens/overview_screen/widgets/graph_section.dart';
import 'package:picos/screens/overview_screen/widgets/my_health_section.dart';
import 'widgets/input_card_section.dart';
import 'widgets/progress_section.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: const Color.fromARGB(255, 15, 88, 104),
          child: const InputCardSection(),
        ),
        Container(
          constraints: const BoxConstraints(minWidth: double.infinity),
          alignment: Alignment.center,
          color: const Color.fromARGB(255, 9, 70, 85),
          child: const ProgressSection(),
        ),
        const GraphSection(),
        Container(
          color: Colors.blue,
          child: MyHealthSection(),
        ),
      ],
    );
  }
}
