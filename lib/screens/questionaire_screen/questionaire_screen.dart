
import 'package:flutter/material.dart';
import 'package:picos/screens/questionaire_screen/questionaire_card.dart';
import 'question.dart';

class QuestionaireScreen extends StatelessWidget {
  QuestionaireScreen({Key? key}) : super(key: key);

  List<Question> questionList = <Question>[
    Question('the first one', ['reply1', 'reply2', 'reply3']),
    Question('second question', ['another reply', 'yet another one']),
    Question('yet another question', ['reply to yet another question'])
  ];

  /// This method generates the cards. It takes the supplied questions and
  /// puts them on cards. The supplied answers
/*  Iterable<Widget> genCards() sync* {
    // TODO: make it a fancy stream returning function
    for (Question card in questionList) {
      yield Row(
        mainAxisSize: MainAxisSize.max,
        children: [
        Expanded(
        flex: 1,
        child: Card( 
          child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                card.question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                ),
              )
            ),
            Text(card.question),
            ..._genReplies(card.replies)
          ],
        ),
      )
      )
      ]);
    }
  }
*/

  Iterable<Widget> _genReplies(Map<int, String> replies) sync* {
    for (MapEntry reply in replies.entries) {
      yield Row(children: <Widget>[
        Text(reply.value)
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      verticalDirection: VerticalDirection.down,
      children: const <Widget>[
        QuestionaireCard(
          question: 'What food do you like the most?',
          answers: <int, String>{
            1: 'Pizza',
            2: 'Sushi',
            3: 'Curry'
          }
        ),
        QuestionaireCard(
          question: 'Are you feeling well today?',
          answers: <int, String> {
            1: 'Feeling great! :)',
            2: 'Feeling ok'
          },
        )
      ],
    );
  }
}
