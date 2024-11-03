import 'package:cloud_firestore/cloud_firestore.dart';

class StudyPlanRepository {
  final FirebaseFirestore _firestore;

  StudyPlanRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> saveStudyPlan(StudyPlan studyPlan) async {
    try {
      await _firestore.collection('studyPlans').add(studyPlan.toMap());
    } catch (error) {
      throw Exception('Failed to save study plan: $error');
    }
  }

  Future<StudyPlan> fetchStudyPlan(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('studyPlans')
          .where('userId', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return StudyPlan.fromMap(snapshot.docs.first.data());
      } else {
        throw Exception('No study plan found for user $userId');
      }
    } catch (error) {
      throw Exception('Failed to fetch study plan: $error');
    }
  }
}

class StudyPlan {
  final String userId;
  final String examDate;
  final List<String> selectedTopics;

  StudyPlan({
    required this.userId,
    required this.examDate,
    required this.selectedTopics,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'examDate': examDate,
      'selectedTopics': selectedTopics,
    };
  }

  static StudyPlan fromMap(Map<String, dynamic> map) {
    return StudyPlan(
      userId: map['userId'],
      examDate: map['examDate'],
      selectedTopics: List<String>.from(map['selectedTopics']),
    );
  }
}
