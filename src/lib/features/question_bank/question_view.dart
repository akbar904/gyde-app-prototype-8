// lib/features/question_bank/question_view.dart

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'question_viewmodel.dart';
import 'question_repository.dart';

class QuestionView extends StatelessWidget {
  final QuestionViewModel model;

  QuestionView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Bank'),
      ),
      body: ViewModelBuilder<QuestionViewModel>.reactive(
        viewModelBuilder: () => model,
        onModelReady: (model) => model.loadQuestions(),
        builder: (context, model, child) {
          if (model.isBusy) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              LinearProgressIndicator(
                  value: model.currentQuestionIndex / model.questions.length),
              Expanded(
                child: PageView.builder(
                  itemCount: model.questions.length,
                  onPageChanged: (index) {
                    model._currentQuestionIndex = index;
                    model.notifyListeners();
                  },
                  itemBuilder: (context, index) {
                    final question = model.questions[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Question ${index + 1}: ${question.text}'),
                            if (question.imageUrl != null)
                              Image.network(question.imageUrl!),
                            ...question.answerOptions.map((option) {
                              return ListTile(
                                title: Text(option),
                                leading: Radio(
                                  value: option,
                                  groupValue: model.selectedAnswer,
                                  onChanged: (value) {
                                    model.selectAnswer(value);
                                  },
                                ),
                              );
                            }).toList(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (index > 0)
                                  ElevatedButton(
                                    onPressed: model.previousQuestion,
                                    child: Text('Previous'),
                                  ),
                                if (index < model.questions.length - 1)
                                  ElevatedButton(
                                    onPressed: model.nextQuestion,
                                    child: Text('Next'),
                                  ),
                                if (index == model.questions.length - 1)
                                  ElevatedButton(
                                    onPressed: model.submitAnswer,
                                    child: Text('Submit'),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
