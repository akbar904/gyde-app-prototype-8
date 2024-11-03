import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IQuestionRepository {
  Future<List<Question>> fetchQuestions();
}

class QuestionRepository implements IQuestionRepository {
  final FirebaseFirestore firestore;

  QuestionRepository({required this.firestore});

  @override
  Future<List<Question>> fetchQuestions() async {
    try {
      final snapshot = await firestore.collection('questions').get();
      return snapshot.docs.map((doc) => Question.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }
}

class Question {
  final String id;
  final String text;
  final List<String> options;

  Question({
    required this.id,
    required this.text,
    required this.options,
  });

  factory Question.fromMap(Map<String, dynamic> data) {
    return Question(
      id: data['id'] as String,
      text: data['text'] as String,
      options: List<String>.from(data['options'] as List),
    );
  }
}
