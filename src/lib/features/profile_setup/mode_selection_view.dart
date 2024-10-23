import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/profile_setup/profile_setup_viewmodel.dart';
import 'package:gap/gap.dart';

class ModeSelectionView extends ViewModelBuilderWidget<ProfileSetupViewModel> {
  @override
  Widget builder(
      BuildContext context, ProfileSetupViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Your Mode',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(8),
              const Text(
                'Please let us know which account type suits you best.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const Gap(40),
              _buildModeCard(
                context: context,
                title: 'Business Mode',
                description: 'For corporate and business use',
                icon: Icons.business,
                onTap: () => viewModel.selectBusinessMode(),
                isSelected: viewModel.isBusinessMode,
              ),
              const Gap(16),
              _buildModeCard(
                context: context,
                title: 'Personal Mode',
                description: 'For individual use',
                icon: Icons.person,
                onTap: () => viewModel.selectPersonalMode(),
                isSelected: !viewModel.isBusinessMode,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: viewModel.modeSelected
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

  Widget _buildModeCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }

  @override
  ProfileSetupViewModel viewModelBuilder(BuildContext context) =>
      ProfileSetupViewModel();
}
