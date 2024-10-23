import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import '../onboarding_viewmodel.dart';

class AuthOptionsView extends ViewModelBuilderWidget<OnboardingViewModel> {
  @override
  Widget builder(
      BuildContext context, OnboardingViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                'Choose Your Preferred\nSign In Method',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(40),
              ElevatedButton(
                onPressed: viewModel.navigateToPhoneInput,
                child: const Text('Continue with Phone'),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: viewModel.navigateToEmailCollection,
                child: const Text('Continue with Email'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  OnboardingViewModel viewModelBuilder(BuildContext context) =>
      OnboardingViewModel();
}
