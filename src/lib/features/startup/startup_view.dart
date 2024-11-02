
// lib/features/startup/startup_view.dart
import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/authentication/login_view.dart';
import 'package:my_app/features/study_plan/study_plan_view.dart';
import 'package:my_app/features/progress_tracking/progress_dashboard_view.dart';

void main() {
	setupLocator();
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'AorteQ',
			theme: ThemeData(
				primarySwatch: Colors.blue,
			),
			onGenerateRoute: Router.generateRoute,
			initialRoute: Routes.loginView,
		);
	}
}

@StackedApp(
	routes: [
		MaterialRoute(page: LoginView, initial: true),
		MaterialRoute(page: StudyPlanView),
		MaterialRoute(page: ProgressDashboardView),
	],
)
class App {}
