import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';

class TermsConditionsView extends ViewModelBuilderWidget {
  @override
  Widget builder(BuildContext context, ViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please read these terms of use carefully before using this platform',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Gap(24),
              Text(
                'Welcome to Gyde! By using our services, you agree to the following terms and conditions. Please read them carefully.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle continue action
                      },
                      child: Text(
                          'By continuing, you have read and agree to our terms and condition.'),
                    ),
                  ),
                ],
              ),
              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ViewModel viewModelBuilder(BuildContext context) {
    return ViewModel();
  }
}
