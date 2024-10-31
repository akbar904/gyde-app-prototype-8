
// lib/features/study_planning/study_plan_view.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/study_planning/study_plan_viewmodel.dart';

class StudyPlanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudyPlanViewModel>.reactive(
      viewModelBuilder: () => StudyPlanViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Study Plan'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your Study Plan:',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              if (model.isLoading)
                CircularProgressIndicator()
              else
                Text(
                  model.studyPlan,
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: model.generateNewPlan,
                child: Text('Generate New Plan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

```dart
// lib/features/study_planning/study_plan_viewmodel.dart
import 'package:stacked/stacked.dart';

class StudyPlanViewModel extends BaseViewModel {
  String _studyPlan = 'No plan generated yet.';
  bool _isLoading = false;

  String get studyPlan => _studyPlan;
  bool get isLoading => _isLoading;

  void generateNewPlan() async {
    setBusy(true);
    _isLoading = true;
    notifyListeners();

    // Simulate a network call or complex calculation
    await Future.delayed(Duration(seconds: 2));

    _studyPlan = 'New personalized study plan generated!';
    _isLoading = false;
    setBusy(false);
    notifyListeners();
  }
}
