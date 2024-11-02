
// lib/features/home/home_view.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/authentication/login_viewmodel.dart';
import 'package:my_app/features/study_plan/study_plan_viewmodel.dart';
import 'package:my_app/features/question_bank/question_viewmodel.dart';
import 'package:my_app/features/progress_tracking/progress_dashboard_viewmodel.dart';

class HomeView extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text('Home')),
			body: Column(
				children: [
					// Implement navigation or buttons to navigate to various views
					ElevatedButton(
						onPressed: () {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => LoginView()),
							);
						},
						child: Text('Go to Login'),
					),
					ElevatedButton(
						onPressed: () {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => StudyPlanView()),
							);
						},
						child: Text('Go to Study Plan'),
					),
					ElevatedButton(
						onPressed: () {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => QuestionView()),
							);
						},
						child: Text('Go to Question Bank'),
					),
					ElevatedButton(
						onPressed: () {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => ProgressDashboardView()),
							);
						},
						child: Text('Go to Progress Dashboard'),
					),
				],
			),
		);
	}
}
