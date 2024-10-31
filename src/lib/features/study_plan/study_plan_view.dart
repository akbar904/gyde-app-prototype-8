import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'study_plan_viewmodel.dart';

class StudyPlanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudyPlanViewModel>.reactive(
      viewModelBuilder: () => StudyPlanViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Personalized Study Plan',
            style: Theme.of(context).textTheme.headline6,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 4.0,
        ),
        body: model.isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16.0),
                    Text(
                      'Generating your personalized study plan...',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Personalized Study Plan is Ready!',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 16.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: model.studyPlan.length,
                        itemBuilder: (context, index) {
                          final week = model.studyPlan[index];
                          return Card(
                            child: ListTile(
                              title: Text('Week ${index + 1}'),
                              subtitle: Text(
                                '${week.hoursPerWeek} hours - ${week.modulesCount} modules',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: model.clearStudyPlan,
                      child: Text(
                        'Clear Study Plan',
                        style: Theme.of(context).textTheme.button,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
