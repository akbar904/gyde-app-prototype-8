import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../ui/common/app_colors.dart';
import '../../../ui/common/ui_helpers.dart';
import '../profile_setup_viewmodel.dart';

class CompanyInfoView extends StackedView<ProfileSetupViewModel> {
  @override
  Widget builder(
      BuildContext context, ProfileSetupViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40),
              const Text(
                'Your Profile',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Gap(8),
              const Text(
                'Provide your basic details for a personalized experience.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Gap(32),
              TextField(
                onChanged: (value) => viewModel.setFirstName(value),
                decoration: const InputDecoration(
                    labelText: 'First Name', hintText: 'Your first name'),
              ),
              const Gap(16),
              TextField(
                onChanged: (value) => viewModel.setLastName(value),
                decoration: const InputDecoration(
                    labelText: 'Last Name', hintText: 'Your last name'),
              ),
              const Gap(16),
              TextField(
                onChanged: (value) => viewModel.setCompanyName(value),
                decoration: const InputDecoration(
                    labelText: 'Company Name', hintText: 'Your company name'),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: viewModel.navigateToPackageSelection,
                  child: const Text('Next'),
                ),
              ),
              const Gap(16),
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
