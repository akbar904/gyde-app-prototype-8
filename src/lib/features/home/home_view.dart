
// exam_date_view.dart

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import 'exam_date_viewmodel.dart';

class ExamDateView extends StatelessWidget {
	const ExamDateView({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<ExamDateViewModel>.reactive(
			viewModelBuilder: () => ExamDateViewModel(),
			builder: (context, model, child) => Scaffold(
				appBar: AppBar(
					title: const Text('Select Exam Date'),
					leading: IconButton(
						icon: const Icon(Icons.arrow_back),
						onPressed: model.navigateBack,
					),
				),
				body: SafeArea(
					child: Padding(
						padding: const EdgeInsets.all(16.0),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.stretch,
							children: [
								const Text(
									'When is your exam?',
									style: TextStyle(
										fontSize: 24,
										fontWeight: FontWeight.bold,
									),
								),
								const Gap(20),
								CalendarDatePicker(
									initialDate: DateTime.now(),
									firstDate: DateTime.now(),
									lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
									onDateChanged: model.selectExamDate,
								),
								const Spacer(),
								ElevatedButton(
									onPressed: model.selectedDate != null ? model.continueToStudyPlan : null,
									child: const Text('Continue'),
								),
								const Gap(16),
							],
						),
					),
				),
			),
		);
	}
}

// exam_date_viewmodel.dart

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';

class ExamDateViewModel extends BaseViewModel {
	final _navigationService = locator<NavigationService>();
	DateTime? _selectedDate;

	DateTime? get selectedDate => _selectedDate;

	void selectExamDate(DateTime date) {
		_selectedDate = date;
		notifyListeners();
	}

	void navigateBack() {
		_navigationService.back();
	}

	void continueToStudyPlan() {
		if (_selectedDate != null) {
			// Navigate to study plan view
			_navigationService.navigateTo(Routes.studyPlanView);
		}
	}
}
