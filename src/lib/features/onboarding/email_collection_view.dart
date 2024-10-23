import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import '../onboarding_viewmodel.dart';

class EmailCollectionView extends StackedView<OnboardingViewModel> {
  @override
  Widget builder(
      BuildContext context, OnboardingViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: viewModel.navigateBack,
              ),
              const Gap(32),
              const Text(
                'Stay Connected',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              const Text(
                'To provide you with tailored services and updates, please share your email with us.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const Gap(32),
              TextField(
                controller: viewModel.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: viewModel.setEmail,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: viewModel.validateAndProceed,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Continue'),
                  ),
                ),
              ),
              const Gap(24),
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
