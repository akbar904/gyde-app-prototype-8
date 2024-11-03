
// lib/features/question_bank/question_view.dart

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'question_viewmodel.dart';

class QuestionView extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<QuestionViewModel>.reactive(
			viewModelBuilder: () => QuestionViewModel(questionRepository: locator<QuestionRepository>()), // Assuming locator is set up
			onModelReady: (model) => model.loadQuestions(),
			builder: (context, model, child) {
				return Scaffold(
					appBar: AppBar(
						title: Text('Question Bank'),
					),
					body: model.isBusy
						? Center(child: CircularProgressIndicator())
						: model.hasError
							? Center(child: Text('Error loading questions: ${model.errorMessage}'))
							: Column(
								children: [
									Padding(
										padding: const EdgeInsets.all(16.0),
										child: Text(
											'Question ${model.currentQuestionIndex + 1}/${model.questions.length}',
											style: Theme.of(context).textTheme.headlineMedium,
										),
									),
									Expanded(
										child: Card(
											margin: const EdgeInsets.all(16.0),
											child: Padding(
												padding: const EdgeInsets.all(16.0),
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													children: [
														Text(
															model.questions[model.currentQuestionIndex].text,
															style: Theme.of(context).textTheme.bodyLarge,
														),
														if (model.questions[model.currentQuestionIndex].imageUrl != null)
															Image.network(model.questions[model.currentQuestionIndex].imageUrl!),
														const SizedBox(height: 16.0),
														...model.questions[model.currentQuestionIndex].options.map((option) {
															return ListTile(
																title: Text(option, style: Theme.of(context).textTheme.bodyMedium),
																onTap: () => model.selectAnswer(option),
																selected: model.selectedAnswer == option,
															);
														}).toList(),
														const SizedBox(height: 16.0),
														Row(
															mainAxisAlignment: MainAxisAlignment.spaceBetween,
															children: [
																ElevatedButton(
																	onPressed: model.hasPreviousQuestion ? model.previousQuestion : null,
																	child: Text('Previous', style: Theme.of(context).textTheme.labelLarge),
																),
																ElevatedButton(
																	onPressed: model.hasNextQuestion ? model.nextQuestion : null,
																	child: Text('Next', style: Theme.of(context).textTheme.labelLarge),
																),
															],
														),
													],
												),
											),
										),
									),
								],
							),
				);
			},
		);
	}
}
