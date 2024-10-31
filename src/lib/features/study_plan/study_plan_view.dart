import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'study_plan_viewmodel.dart';

class StudyPlanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudyPlanViewModel>.reactive(
      viewModelBuilder: () => StudyPlanViewModel(NavigationService()),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Study Plan',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          body: model.isBusy
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16.0),
                      Text(
                        'Generating your personalized study plan',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                )
              : _buildStudyPlanContent(context, model),
        );
      },
    );
  }

  Widget _buildStudyPlanContent(
      BuildContext context, StudyPlanViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Personalized Study Plan is Ready!',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: model.studyPlan.length,
              itemBuilder: (context, index) {
                final weekPlan = model.studyPlan[index];
                return Card(
                  child: ListTile(
                    title: Text('Week ${index + 1}'),
                    subtitle: Text(
                      '${weekPlan.hours} hours, ${weekPlan.modules} modules',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: model.startFirstModule,
            child: Text('Start First Module'),
            style: ElevatedButton.styleFrom(
              primary:
                  Theme.of(context).accentColor, // Using Material accent color
            ),
          ),
        ],
      ),
    );
  }
}
