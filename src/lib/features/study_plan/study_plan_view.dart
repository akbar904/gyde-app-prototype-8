import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/features/study_plan/study_plan_viewmodel.dart';

class StudyPlanView extends StackedView<StudyPlanViewModel> {
  const StudyPlanView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StudyPlanViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Study Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: viewModel.isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Generating your study plan...'),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Exam Type Selection
                    const Text(
                      'Select Exam Type',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: viewModel.examType.isEmpty
                          ? null
                          : viewModel.examType,
                      hint: const Text('Choose exam type'),
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(value: 'USMLE', child: Text('USMLE')),
                        DropdownMenuItem(value: 'NCLEX', child: Text('NCLEX')),
                      ],
                      onChanged: (value) => viewModel.setExamType(value ?? ''),
                    ),

                    const SizedBox(height: 24),

                    // Topics Selection
                    const Text(
                      'Select Study Topics',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 8,
                      children: [
                        'Anatomy',
                        'Physiology',
                        'Pathology',
                        'Pharmacology'
                      ]
                          .map((topic) => FilterChip(
                                label: Text(topic),
                                selected:
                                    viewModel.selectedTopics.contains(topic),
                                onSelected: (selected) {
                                  final topics = List<String>.from(
                                      viewModel.selectedTopics);
                                  if (selected) {
                                    topics.add(topic);
                                  } else {
                                    topics.remove(topic);
                                  }
                                  viewModel.setSelectedTopics(topics);
                                },
                              ))
                          .toList(),
                    ),

                    const SizedBox(height: 24),

                    // Study Time Selection
                    const Text(
                      'Weekly Study Time',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: viewModel.studyTime.isEmpty
                          ? null
                          : viewModel.studyTime,
                      hint: const Text('Select weekly hours'),
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(value: '10', child: Text('10 hours')),
                        DropdownMenuItem(value: '20', child: Text('20 hours')),
                        DropdownMenuItem(value: '30', child: Text('30 hours')),
                      ],
                      onChanged: (value) => viewModel.setStudyTime(value ?? ''),
                    ),

                    const SizedBox(height: 24),

                    // Exam Date Selection
                    const Text(
                      'Exam Date',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListTile(
                      title: Text(
                        viewModel.examDate?.toString() ?? 'Select exam date',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          viewModel.setExamDate(date);
                        }
                      },
                    ),

                    const SizedBox(height: 32),

                    // Generate Plan Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: viewModel.canGeneratePlan
                            ? viewModel.generateStudyPlan
                            : null,
                        child: const Text('Generate Study Plan'),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  StudyPlanViewModel viewModelBuilder(BuildContext context) =>
      StudyPlanViewModel(NavigationService());
}
