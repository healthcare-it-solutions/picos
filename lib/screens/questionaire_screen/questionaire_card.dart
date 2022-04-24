import 'package:flutter/material.dart';

// TODO: use this class to generate cards, move a part from the screen
// functionality to this class
class _QuestionaireCardState extends State<QuestionaireCard> {
  int? _selectedElement;

  Iterable<Widget> _genReplies() sync* {
    for (MapEntry<int, String> answer in widget.answers.entries) {
      yield RadioListTile<int>(
        title: Text(answer.value),
        value: answer.key,
        groupValue: _selectedElement,
        onChanged: (int? newSelection) {
          setState(() {
            _selectedElement = newSelection;
          });
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(
            widget.question,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          Text(widget.question),
          ..._genReplies()
        ],
      ),
    ));
  }
}

class QuestionaireCard extends StatefulWidget {
  const QuestionaireCard(
      {required this.question, required this.answers, Key? key})
      : super(key: key);

  @override
  State<QuestionaireCard> createState() => _QuestionaireCardState();

  final String question;
  final Map<int, String> answers;
}
