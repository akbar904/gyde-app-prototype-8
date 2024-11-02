
// lib/features/startup/startup_view.dart

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/authentication/login_viewmodel.dart';
import 'package:gyde_app/features/study_plan/study_plan_viewmodel.dart';
import 'package:gyde_app/features/question_bank/question_viewmodel.dart';
import 'package:gyde_app/features/progress_tracking/progress_dashboard_viewmodel.dart';

class StartupView extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text('Startup')),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					children: [
						Text('Welcome to the AorteQ App!'),
						SizedBox(height: 20),
						ElevatedButton(
							onPressed: () {
								Navigator.push(
									context,
									MaterialPageRoute(builder: (context) => LoginView()),
								);
							},
							child: Text('Login'),
						),
						SizedBox(height: 20),
						ElevatedButton(
							onPressed: () {
								Navigator.push(
									context,
									MaterialPageRoute(builder: (context) => StudyPlanView()),
								);
							},
							child: Text('Study Plan Setup'),
						),
						SizedBox(height: 20),
						ElevatedButton(
							onPressed: () {
								Navigator.push(
									context,
									MaterialPageRoute(builder: (context) => QuestionView()),
								);
							},
							child: Text('Question Bank'),
						),
						SizedBox(height: 20),
						ElevatedButton(
							onPressed: () {
								Navigator.push(
									context,
									MaterialPageRoute(builder: (context) => ProgressDashboardView()),
								);
							},
							child: Text('Progress Dashboard'),
						),
					],
				),
			),
		);
	}
}
