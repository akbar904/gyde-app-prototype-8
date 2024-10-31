import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'progress_viewmodel.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProgressViewModel>.reactive(
      viewModelBuilder: () => ProgressViewModel(NavigationService()),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Progress Tracking Dashboard'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, [User\'s Name]',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8.0),
              Text(
                'Exam Countdown: [days] days remaining',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 16.0),
              CircularProgressIndicator(
                value: model.overallCompletion,
                strokeWidth: 8.0,
              ),
              SizedBox(height: 16.0),
              Text(
                'Weekly Progress',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Placeholder for a weekly progress bar chart
              SizedBox(height: 16.0),
              Text(
                'Study Streak: [streak count] days',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 16.0),
              Text(
                'Score Prediction',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Placeholder for score prediction meter
              SizedBox(height: 16.0),
              Text(
                'Recent Assessment Scores',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Placeholder for recent assessments
              SizedBox(height: 16.0),
              Text(
                'Weekly Subject Breakdown',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Placeholder for performance metrics
            ],
          ),
        ),
      ),
    );
  }
}
