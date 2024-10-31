
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'question_viewmodel.dart';

class QuestionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuestionViewModel>.reactive(
      viewModelBuilder: () => QuestionViewModel(
        navigationService: StackedService.navigatorKey.currentState!,
        questionRepository: MockQuestionRepository(),
      ),
      onModelReady: (model) => model.loadQuestions(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Question Bank'),
        ),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  LinearProgressIndicator(
                    value: model.progress,
                    semanticsLabel: 'Question Progress',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${model.currentQuestionNumber}/${model.totalQuestions}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 20),
                        Text(
                          model.currentQuestionText,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        if (model.hasImage)
                          Image.network(
                            model.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ...model.answerOptions.map((option) => RadioListTile(
                              title: Text(option),
                              value: option,
                              groupValue: model.selectedAnswer,
                              onChanged: (value) {
                                model.selectAnswer(value as String);
                              },
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: model.navigateToPrevious,
                              child: Text('Previous'),
                            ),
                            ElevatedButton(
                              onPressed: model.navigateToNext,
                              child: Text('Next'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
