
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'study_plan_viewmodel.dart';

class StudyPlanView extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(
			viewModelBuilder: () => StudyPlanViewModel(),
			onModelReady: (viewModel) => viewModel.resetStudyPlan(),
			builder: (context, viewModel, child) {
				return Scaffold(
					appBar: AppBar(
						title: Text('Study Plan Setup'),
					),
					body: viewModel.isLoading
						? Center(child: CircularProgressIndicator())
						: Column(
							children: [
								Padding(
									padding: const EdgeInsets.all(16.0),
									child: Text(
										"Let's tailor things to your study plan",
										style: Theme.of(context).textTheme.headlineMedium,
									),
								),
								if (viewModel.errorMessage != null)
									Padding(
										padding: const EdgeInsets.all(8.0),
										child: Text(
											viewModel.errorMessage!,
											style: TextStyle(color: Colors.red),
										),
									),
								Stepper(
									currentStep: viewModel.currentStep,
									onStepContinue: viewModel.nextStep,
									onStepCancel: viewModel.previousStep,
									steps: [
										Step(
											title: Text('Exam Selection & Date', style: Theme.of(context).textTheme.titleMedium),
											content: Column(
												children: [
													DropdownButton<String>(
														value: viewModel.selectedExam,
														onChanged: viewModel.setExam,
														items: <String>['USMLE Step 1', 'Other']
															.map<DropdownMenuItem<String>>((String value) {
																return DropdownMenuItem<String>(
																	value: value,
																	child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
																);
															}).toList(),
													),
													TextField(
														decoration: InputDecoration(
															labelText: 'Exam Date',
															labelStyle: Theme.of(context).textTheme.labelMedium,
														),
														readOnly: true,
														onTap: () async {
															DateTime? pickedDate = await showDatePicker(
																context: context,
																initialDate: DateTime.now(),
																firstDate: DateTime(2000),
																lastDate: DateTime(2101),
															);
															if (pickedDate != null) {
																viewModel.setExamDate(pickedDate);
															}
														},
													),
												],
											),
										),
										Step(
											title: Text('Topic Selection', style: Theme.of(context).textTheme.titleMedium),
											content: Column(
												children: [
													Wrap(
														spacing: 8.0,
														children: viewModel.topics.map((topic) {
															return FilterChip(
																label: Text(topic, style: Theme.of(context).textTheme.bodyMedium),
																selected: viewModel.selectedTopics.contains(topic),
																onSelected: (bool selected) {
																	viewModel.selectTopic(topic, selected);
																},
															);
														}).toList(),
													),
												],
											),
										),
										Step(
											title: Text('Study Schedule', style: Theme.of(context).textTheme.titleMedium),
											content: Column(
												children: [
													TextField(
														decoration: InputDecoration(
															labelText: 'Hours per day',
															labelStyle: Theme.of(context).textTheme.labelMedium,
														),
														onChanged: viewModel.setStudyHours,
													),
												],
											),
										),
									],
								),
								Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: [
										ElevatedButton(
											onPressed: viewModel.previousStep,
											child: Text('Back', style: Theme.of(context).textTheme.labelLarge),
										),
										ElevatedButton(
											onPressed: () async {
												await viewModel.generateStudySchedule();
											},
											child: Text('Continue', style: Theme.of(context).textTheme.labelLarge),
										),
									],
								),
							],
						),
				);
			},
		);
	}
}
