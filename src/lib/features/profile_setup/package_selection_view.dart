import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/features/profile_setup/package_selection_viewmodel.dart';

class PackageSelectionView extends StackedView<PackageSelectionViewModel> {
  const PackageSelectionView({super.key});

  @override
  Widget builder(BuildContext context, PackageSelectionViewModel viewModel,
      Widget? child,) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Your Package',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold,),
              ),
              verticalSpaceMedium,
              Text(
                'Choose the package that best suits your needs',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white70),
              ),
              verticalSpaceLarge,
              Expanded(
                child: ListView(
                  children: [
                    _PackageCard(
                      title: 'Corporate Elite Package',
                      price: 5000,
                      features: const [
                        '24/7 Priority Service',
                        'Dedicated Account Manager',
                        'Corporate Fleet Access',
                        'Priority Booking',
                      ],
                      onTap: () => viewModel.selectPackage('corporate_elite'),
                      isSelected:
                          viewModel.selectedPackage == 'corporate_elite',
                    ),
                    verticalSpaceMedium,
                    _PackageCard(
                      title: 'Executive Package',
                      price: 1000,
                      features: const [
                        'Professional Chauffeurs',
                        'Luxury Vehicles',
                        '24/7 Support',
                        'Flexible Booking',
                      ],
                      onTap: () => viewModel.selectPackage('executive'),
                      isSelected: viewModel.selectedPackage == 'executive',
                    ),
                    verticalSpaceMedium,
                    _PackageCard(
                      title: 'VIP Package',
                      price: 2500,
                      features: const [
                        'Premium Vehicle Selection',
                        'VIP Airport Service',
                        'Concierge Support',
                        'Advanced Booking',
                      ],
                      onTap: () => viewModel.selectPackage('vip'),
                      isSelected: viewModel.selectedPackage == 'vip',
                    ),
                  ],
                ),
              ),
              verticalSpaceMedium,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: viewModel.selectedPackage.isNotEmpty
                      ? viewModel.continueToPayment
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PackageSelectionViewModel viewModelBuilder(BuildContext context) =>
      PackageSelectionViewModel();
}

class _PackageCard extends StatelessWidget {

  const _PackageCard({
    required this.title,
    required this.price,
    required this.features,
    required this.onTap,
    required this.isSelected,
  });
  final String title;
  final int price;
  final List<String> features;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            verticalSpaceSmall,
            Text(
              '\$$price/month',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primary, fontWeight: FontWeight.bold,),
            ),
            verticalSpaceMedium,
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      horizontalSpaceSmall,
                      Text(
                        feature,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),),
          ],
        ),
      ),
    );
  }
}
