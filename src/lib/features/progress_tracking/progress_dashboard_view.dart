
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'progress_dashboard_viewmodel.dart';

class ProgressDashboardView extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<ProgressDashboardViewModel>.reactive(
			viewModelBuilder: () => ProgressDashboardViewModel(),
			onModelReady: (model) => model.loadProgress(),
			builder: (context, model, child) {
				return Scaffold(
					appBar: AppBar(
						title: const Text('Progress Dashboard'),
					),
					body: Padding(
						padding: const EdgeInsets.all(16.0),
						child: model.isBusy
							? Center(child: CircularProgressIndicator())
							: model.hasError
								? Column(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										Text(
											'Error: ${model.errorMessage}',
											style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
										),
										const SizedBox(height: 20),
										TextButton(
											onPressed: model.loadProgress,
											child: const Text('Retry'),
										),
									],
								)
								: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(
											'Completed Questions: ${model.completedQuestions}',
											style: Theme.of(context).textTheme.headlineMedium,
										),
										const SizedBox(height: 20),
										Text(
											'TOTAL Questions: ${model.totalQuestions}',
											style: Theme.of(context).textTheme.bodyMedium,
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
											style: Theme.of(context).textTheme.bodyMedium,
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
										Navigator.pop(context);
									},
									child: const Text('Back'),
								),
								TextButton(
									onPressed: model.goToNextScreen,
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
