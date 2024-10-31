import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:com.com.walturn.aorteq_app/app/app.locator.dart';
import 'package:com.com.walturn.aorteq_app/app/app.router.dart';
import 'package:com.com.walturn.aorteq_app/ui/common/app_colors.dart';
import 'package:com.com.walturn.aorteq_app/ui/common/ui_helpers.dart';
import 'package:com.com.walturn.aorteq_app/features/study_planning/exam_selection_viewmodel.dart';

class ExamSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExamSelectionViewModel>.reactive(
      viewModelBuilder: () => locator<ExamSelectionViewModel>(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Exam Selection'),
          backgroundColor: AppColors.primary,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select Your Exam',
                style: Theme.of(context).textTheme.headline5,
              ),
              verticalSpaceMedium,
              Expanded(
                child: ListView.builder(
                  itemCount: model.exams.length,
                  itemBuilder: (context, index) {
                    final exam = model.exams[index];
                    return ListTile(
                      title: Text(exam.name),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () => model.selectExam(exam),
                    );
                  },
                ),
              ),
              verticalSpaceMedium,
              if (model.isBusy) Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
