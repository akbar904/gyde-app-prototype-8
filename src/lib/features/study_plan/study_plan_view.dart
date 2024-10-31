import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/study_plan/study_plan_viewmodel.dart';

class StudyPlanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudyPlanViewModel>.reactive(
      viewModelBuilder: () => StudyPlanViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Study Plan Setup'),
        ),
        body: Stepper(
          currentStep: model.currentStep,
          onStepContinue: () {
            if (model.currentStep < 2) {
              model.nextStep();
            } else {
              // Collect all plan details and pass them to setupStudyPlan
              Map<String, dynamic> planDetails = {
                'selectedExam': model.selectedExam,
                'selectedDate': model.selectedDate,
                'selectedTopics': model.selectedTopics,
                'hoursPerDay': model.hoursController.text,
                'selectedDays': model.selectedDays,
              };
              model.setupStudyPlan(planDetails);
            }
          },
          onStepCancel: model.previousStep,
          steps: <Step>[
            Step(
              title: Text('Exam Selection & Date'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Let's tailor things to your study plan"),
                  DropdownButton<String>(
                    value: model.selectedExam,
                    onChanged: model.selectExam,
                    items: model.exams
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  Text('Select Exam Date'),
                  ElevatedButton(
                    onPressed: () => model.selectDate(context),
                    child: Text(model.selectedDate == null
                        ? 'Choose Date'
                        : model.selectedDate.toString()),
                  ),
                ],
              ),
              isActive: model.currentStep >= 0,
              state: model.currentStep > 0
                  ? StepState.complete
                  : StepState.indexed,
            ),
            Step(
              title: Text('Topic Selection'),
              content: Column(
                children: <Widget>[
                  Text('Select Topics'),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: model.topics.map((topic) {
                      return FilterChip(
                        label: Text(topic),
                        selected: model.selectedTopics.contains(topic),
                        onSelected: (bool selected) {
                          model.toggleTopicSelection(topic, selected);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
              isActive: model.currentStep >= 1,
              state: model.currentStep > 1
                  ? StepState.complete
                  : StepState.indexed,
            ),
            Step(
              title: Text('Study Schedule'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Set Study Schedule'),
                  Text('Hours per day'),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: model.hoursController,
                    decoration: InputDecoration(
                      labelText: 'Hours',
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Select Study Days'),
                  ToggleButtons(
                    children: model.daysOfWeek.map((day) => Text(day)).toList(),
                    isSelected: model.selectedDays,
                    onPressed: model.toggleDaySelection,
                  ),
                ],
              ),
              isActive: model.currentStep >= 2,
              state: StepState.indexed,
            ),
          ],
        ),
      ),
    );
  }
}
