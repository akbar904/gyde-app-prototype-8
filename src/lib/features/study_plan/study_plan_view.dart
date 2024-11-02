
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'study_plan_viewmodel.dart';

class StudyPlanView extends StatelessWidget {
	final StudyPlanViewModel viewModel;

	StudyPlanView(this.viewModel);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Study Plan Setup'),
			),
			body: SingleChildScrollView(
				child: Column(
					children: [
						Stepper(
							currentStep: viewModel.currentStep,
							onStepTapped: viewModel.onStepTapped,
							onStepContinue: viewModel.onStepContinue,
							onStepCancel: viewModel.onStepCancel,
							steps: viewModel.steps,
						),
						Padding(
							padding: const EdgeInsets.all(16.0),
							child: ElevatedButton(
								onPressed: () {
									viewModel.generateSchedule();
								},
								child: Text('Generate Study Schedule'),
							),
						),
					],
				),
			),
		);
	}
}
```

```
import 'package:stacked/stacked.dart';
import 'study_plan_repository.dart';

class StudyPlanViewModel extends BaseViewModel {
	final StudyPlanRepository _repository;
	int _currentStep = 0;
	final List<Step> _steps;

	StudyPlanViewModel(this._repository) : _steps = _initializeSteps();

	int get currentStep => _currentStep;
	List<Step> get steps => _steps;

	void onStepTapped(int step) {
		_currentStep = step;
		notifyListeners();
	}

	void onStepContinue() {
		if (_currentStep < _steps.length - 1) {
			_currentStep++;
		}
		notifyListeners();
	}

	void onStepCancel() {
		if (_currentStep > 0) {
			_currentStep--;
		}
		notifyListeners();
	}

	void selectExam(String exam) {
		_repository.setSelectedExam(exam);
		notifyListeners();
	}

	void selectTopics(List<String> topics) {
		_repository.setSelectedTopics(topics);
		notifyListeners();
	}

	void generateSchedule() {
		_repository.calculateSchedule();
		notifyListeners();
	}

	static List<Step> _initializeSteps() {
		return [
			Step(
				title: Text('Select Exam'),
				content: Column(
					children: [
						// Add logic and UI for exam selection
					],
				),
			),
			Step(
				title: Text('Select Topics'),
				content: Column(
					children: [
						// Add logic and UI for topic selection
					],
				),
			),
			Step(
				title: Text('Review and Generate'),
				content: Column(
					children: [
						// Add logic for review before generating schedule
					],
				),
			),
		];
	}
}
```

```
class StudyPlanRepository {
	String? _selectedExam;
	List<String>? _selectedTopics;

	void setSelectedExam(String exam) {
		_selectedExam = exam;
	}

	void setSelectedTopics(List<String> topics) {
		_selectedTopics = topics;
	}

	void calculateSchedule() {
		// Logic to calculate the study schedule based on selected exam and topics
	}
}
