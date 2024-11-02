
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'progress_dashboard_viewmodel.dart';
import 'progress_repository.dart';

class ProgressDashboardView extends StatelessWidget {
	final ProgressRepository _repository;

	ProgressDashboardView({Key? key, required ProgressRepository repository})
		: _repository = repository,
		super(key: key);

	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<ProgressDashboardViewModel>.reactive(
			viewModelBuilder: () => ProgressDashboardViewModel(_repository),
			onModelReady: (model) => model.loadProgress(),
			builder: (context, model, child) {
				return Scaffold(
					appBar: AppBar(
						title: const Text('Progress Dashboard'),
					),
					body: Padding(
						padding: const EdgeInsets.all(16.0),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									'Completed Questions: ${model.completedQuestions}',
									style: Theme.of(context).textTheme.headlineMedium, // Updated to use theme
								),
								const SizedBox(height: 20),
								Text(
									'TOTAL Questions: ${model.totalQuestions}',
									style: Theme.of(context).textTheme.bodyMedium, // Updated to use theme
								),
								const SizedBox(height: 20),
								CircularProgressIndicator(
									value: model.totalQuestions > 0
										? model.completedQuestions / model.totalQuestions
										: 0,
									strokeWidth: 8,
								),
								const SizedBox(height: 20),
								Text(
									'Your Progress: ${model.totalQuestions > 0 ? (model.completedQuestions / model.totalQuestions * 100).toStringAsFixed(2) : 0}%',
									style: Theme.of(context).textTheme.bodyMedium, // Updated to use theme
								),
								const SizedBox(height: 20),
								// Additional UI components for weekly progress and metrics can be added here
							],
						),
					),
					bottomNavigationBar: BottomAppBar(
						child: Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: [
								TextButton(
									onPressed: () {
										// Implement the navigation to the previous screen
										Navigator.pop(context);
									},
									child: const Text('Back'),
								),
								TextButton(
									onPressed: () {
										// Implement the navigation to the next screen
										// Assuming a method exists in the ViewModel
										model.goToNextScreen();
									},
									child: const Text('Next'),
								),
							],
						),
					),
				);
			},
		);
	}
}
