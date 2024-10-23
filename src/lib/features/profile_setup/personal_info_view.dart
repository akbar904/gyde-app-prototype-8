import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import '../profile_setup_viewmodel.dart';

class PersonalInfoView extends ViewModelBuilderWidget<ProfileSetupViewModel> {
  @override
  Widget builder(
      BuildContext context, ProfileSetupViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Profile',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(8),
              Text(
                'Provide your basic details for a personalized experience.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Gap(32),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  hintText: 'Your first name',
                ),
                onChanged: viewModel.setFirstName,
              ),
              const Gap(16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'Your last name',
                ),
                onChanged: viewModel.setLastName,
              ),
              const Gap(32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: viewModel.isPersonalInfoValid
                      ? viewModel.navigateToNextPage
                      : null,
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ProfileSetupViewModel viewModelBuilder(BuildContext context) =>
      ProfileSetupViewModel();
}
