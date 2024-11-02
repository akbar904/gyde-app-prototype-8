import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'study_plan_viewmodel.dart';
import 'study_plan_repository.dart';

class StudyPlanView extends StatelessWidget {
  final StudyPlanViewModel viewModel;

  StudyPlanView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Plan Setup'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Let's tailor things to your study plan",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Stepper(
            currentStep: viewModel.currentStep,
            onStepContinue: viewModel.nextStep,
            onStepCancel: viewModel.previousStep,
            steps: [
              Step(
                title: Text('Exam Selection & Date'),
                content: Column(
                  children: [
                    DropdownButton<String>(
                      value: viewModel.selectedExam,
                      onChanged: viewModel.setExam,
                      items: <String>['USMLE Step 1', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Exam Date',
                      ),
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
                title: Text('Topic Selection'),
                content: Column(
                  children: [
                    // Multi-select grid layout for topics
                    Wrap(
                      spacing: 8.0,
                      children: viewModel.topics.map((topic) {
                        return FilterChip(
                          label: Text(topic),
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
                title: Text('Study Schedule'),
                content: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Hours per day',
                      ),
                      onChanged: viewModel.setStudyHours,
                    ),
                    // Weekly schedule selector
                    // Implementation for selecting days can go here
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
                child: Text('Back'),
              ),
              ElevatedButton(
                onPressed: viewModel.nextStep,
                child: Text('Continue'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
