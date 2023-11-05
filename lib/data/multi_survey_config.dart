import 'package:jwt_auth/data/multi_answers.dart';

class MultiSurvey {
  final int? count;
  final int? id;
  final List<MultiAnswers>? answers;
  final String? question;
  final String? questionEN;

  MultiSurvey(
      {required this.id,
      this.answers,
      this.question,
      this.questionEN,
      this.count});

  factory MultiSurvey.fromJson(Map<String, dynamic> json) {
    List<dynamic> answersList = json['answers'];

    List<MultiAnswers> parsedAnswers = answersList
        .map((answerJson) => MultiAnswers.fromJson(answerJson))
        .toList();

    return MultiSurvey(
      id: json['id'] as int,
      answers: parsedAnswers,
      question: json['question'],
      questionEN: json['questionEN'],
    );
  }
}
