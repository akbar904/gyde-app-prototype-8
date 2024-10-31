import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './topic_selection_viewmodel.dart';

class TopicSelectionView extends StatelessWidget {
  const TopicSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TopicSelectionViewModel>.reactive(
      viewModelBuilder: () => TopicSelectionViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: viewModel.navigateBack,
          ),
          title: const Text('Topics you want to focus on?'),
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                padding: const EdgeInsets.all(16),
                itemCount: viewModel.availableTopics.length,
                itemBuilder: (context, index) {
                  final topic = viewModel.availableTopics[index];
                  return _buildTopicTile(context, topic, viewModel);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed:
                    viewModel.canProceed ? viewModel.navigateToStudyTime : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicTile(
      BuildContext context, String topic, TopicSelectionViewModel viewModel) {
    return InkWell(
      onTap: () => viewModel.toggleTopic(topic),
      child: Card(
        elevation: viewModel.isTopicSelected(topic) ? 4 : 1,
        color: viewModel.isTopicSelected(topic)
            ? Theme.of(context).primaryColor.withOpacity(0.1)
            : null,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              topic,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: viewModel.isTopicSelected(topic)
                        ? Theme.of(context).primaryColor
                        : null,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
