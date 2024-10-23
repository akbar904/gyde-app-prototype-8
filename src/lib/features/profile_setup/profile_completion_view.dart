import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../profile_setup_viewmodel.dart';

class ProfileCompletionView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useViewModel<ProfileSetupViewModel>();

    return ViewModelBuilder<ProfileSetupViewModel>.reactive(
      viewModelBuilder: () => ProfileSetupViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hi, ${model.firstName}!',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome to Gyde. Please select your personalized experience.',
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Continue'),
                    onPressed: () => model.navigateToMainRides(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
