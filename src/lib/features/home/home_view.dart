
// lib/features/home/home_view.dart

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'authentication/login_viewmodel.dart';
import 'study_plan/study_plan_viewmodel.dart';
import 'question_bank/question_viewmodel.dart';
import 'progress_tracking/progress_dashboard_viewmodel.dart';

class HomeView extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text('Home')),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					children: [
						ElevatedButton(
							onPressed: () {
								navigateToLogin(context);
							},
							child: Text('Login'),
						),
						SizedBox(height: 20),
						ElevatedButton(
							onPressed: () {
								navigateToStudyPlan(context);
							},
							child: Text('Study Plan Setup'),
						),
						SizedBox(height: 20),
						ElevatedButton(
							onPressed: () {
								navigateToQuestionBank(context);
							},
							child: Text('Question Bank'),
						),
						SizedBox(height: 20),
						ElevatedButton(
							onPressed: () {
								navigateToProgressDashboard(context);
							},
							child: Text('Progress Dashboard'),
						),
					],
				),
			),
		);
	}

	void navigateToLogin(BuildContext context) {
		Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => LoginView()),
		);
	}

	void navigateToStudyPlan(BuildContext context) {
		Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => StudyPlanView()),
		);
	}

	void navigateToQuestionBank(BuildContext context) {
		Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => QuestionView()),
		);
	}

	void navigateToProgressDashboard(BuildContext context) {
		Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => ProgressDashboardView()),
		);
	}
}
