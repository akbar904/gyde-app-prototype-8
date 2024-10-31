import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'study_time_viewmodel.dart';

class StudyTimeView extends StatelessWidget {
  const StudyTimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudyTimeViewModel>.reactive(
      viewModelBuilder: () =>
          StudyTimeViewModel(navigationService: locator<NavigationService>()),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Study Time'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => model.navigationService.back(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How many hours can you study each week?',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                _buildTimeOption(context, model, 'less_than_5',
                    'Less than 5 hours per week'),
                _buildTimeOption(
                    context, model, '5_to_10', '5-10 hours per week'),
                _buildTimeOption(
                    context, model, '10_to_20', '10-20 hours per week'),
                _buildTimeOption(context, model, 'more_than_20',
                    'More than 20 hours per week'),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: model.canProceed()
                        ? () =>
                            model.allocateStudyTime(model.selectedTimeOption!)
                        : null,
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeOption(BuildContext context, StudyTimeViewModel model,
      String value, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RadioListTile<String>(
        title: Text(label),
        value: value,
        groupValue: model.selectedTimeOption,
        onChanged: (value) => model.allocateStudyTime(value!),
        selected: model.isTimeOptionSelected(value),
      ),
    );
  }
}
