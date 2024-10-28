import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';

class PackageSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PackageSelectionViewModel>.reactive(
      viewModelBuilder: () => PackageSelectionViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(32),
                  Text(
                    'Select Your Package',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const Gap(8),
                  Text(
                    'Choose the perfect package for your luxury travel needs',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const Gap(32),
                  _buildPackageCard(
                    context,
                    title: 'Corporate Elite Package',
                    price: '5000',
                    features: [
                      '24/7 Priority Service',
                      'Dedicated Account Manager',
                      'Fleet of Premium Vehicles',
                      'Corporate Billing',
                      'Worldwide Coverage'
                    ],
                    onTap: () => model.selectPackage('corporate_elite'),
                  ),
                  const Gap(16),
                  _buildPackageCard(
                    context,
                    title: 'Executive Package',
                    price: '1000',
                    features: [
                      'Priority Booking',
                      'Premium Vehicles',
                      'Airport Transfers',
                      '24/7 Support',
                      'City Coverage'
                    ],
                    onTap: () => model.selectPackage('executive'),
                  ),
                  const Gap(16),
                  _buildPackageCard(
                    context,
                    title: 'VIP Package',
                    price: '2500',
                    features: [
                      'Luxury Vehicle Fleet',
                      'Personal Chauffeur',
                      'Event Transportation',
                      'Premium Support',
                      'Regional Coverage'
                    ],
                    onTap: () => model.selectPackage('vip'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard(
    BuildContext context, {
    required String title,
    required String price,
    required List<String> features,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[900],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const Gap(8),
            Text(
              '\$$price/month',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Gap(16),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle,
                          color: Colors.greenAccent, size: 20),
                      const Gap(8),
                      Text(
                        feature,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class PackageSelectionViewModel extends BaseViewModel {
  void selectPackage(String packageId) {
    // Handle package selection
    notifyListeners();
  }
}
