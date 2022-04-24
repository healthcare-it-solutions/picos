import 'package:flutter/widgets.dart';

@Deprecated('Future refectorings will remove this class, please provide the'
'questions with a proper Map in future')
class Question {
  /// The constructor 'generates' an id for each reply, so the replies can be
  /// tracked later.
  Question(this.question, List<String> r) {
    for (int i = 0; i < r.length; i++) {
      replies.addAll(<int, String>{i: r[i]});
    }
  }

  String question;
  Map<int, String> replies = <int, String>{};
}
