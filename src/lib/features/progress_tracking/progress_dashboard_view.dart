// lib/features/progress_tracking/progress_dashboard_view.dart

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'progress_dashboard_viewmodel.dart';
import 'progress_repository.dart';

class ProgressDashboardView extends StatelessWidget {
  final ProgressRepository progressRepository;

  ProgressDashboardView({Key? key, required this.progressRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProgressDashboardViewModel>.reactive(
      viewModelBuilder: () => ProgressDashboardViewModel(progressRepository),
      onModelReady: (model) => model.fetchProgress(),
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
                if (model.isBusy) CircularProgressIndicator(),
                if (!model.isBusy) ...[
                  Text(
                    'Hello, ${model.userName}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(value: model.overallCompletion),
                  const SizedBox(height: 20),
                  Text(
                    'Weekly Progress',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  // Placeholder for weekly progress chart
                  Container(
                    height: 200,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Recent Scores',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  // Placeholder for recent scores list
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.recentScores.length,
                      itemBuilder: (context, index) {
                        final score = model.recentScores[index];
                        return ListTile(
                          title: Text(score.testName),
                          subtitle: Text(
                              'Score: ${score.score} - Date: ${score.dateTaken}'),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
