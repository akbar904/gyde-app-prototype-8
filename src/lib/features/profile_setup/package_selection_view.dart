import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/profile_setup/profile_setup_viewmodel.dart';

class PackageSelectionView
    extends ViewModelBuilderWidget<ProfileSetupViewModel> {
  @override
  Widget builder(
      BuildContext context, ProfileSetupViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Select Your Package',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 12),
              Text(
                viewModel.isBusinessMode
                    ? 'Choose our premium corporate package'
                    : 'Select a package that suits your needs',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 40),
              Expanded(
                  child: viewModel.isBusinessMode
                      ? _buildBusinessPackage(context, viewModel)
                      : _buildPersonalPackages(context, viewModel)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: viewModel.onContinue,
                      child: const Text('Join This Package'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50)),
                    ),
                    TextButton(
                      onPressed: viewModel.onSkip,
                      child: const Text('Skip for Now'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessPackage(
      BuildContext context, ProfileSetupViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Corporate Elite Package',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            Text(
              '\$5000/month',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 16),
            _buildFeatureItem('Unlimited Rides and Priority Booking'),
            _buildFeatureItem('Access to Luxury Vehicles'),
            _buildFeatureItem('24/7 Customer Support and Concierge Service'),
            _buildFeatureItem('Complimentary In-car Amenities'),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalPackages(
      BuildContext context, ProfileSetupViewModel viewModel) {
    return ListView(
      children: [
        _buildPersonalPackageCard(
            context,
            'Executive Package',
            1000,
            ['Limited Rides', 'Standard Support', 'Basic Amenities'],
            viewModel),
        const SizedBox(height: 16),
        _buildPersonalPackageCard(
            context,
            'VIP Package',
            2500,
            ['Unlimited Rides', 'Priority Support', 'Premium Amenities'],
            viewModel),
      ],
    );
  }

  Widget _buildPersonalPackageCard(BuildContext context, String title,
      int price, List<String> features, ProfileSetupViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            Text(
              '\$$price/month',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 16),
            ...features.map((feature) => _buildFeatureItem(feature)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  @override
  ProfileSetupViewModel viewModelBuilder(BuildContext context) =>
      ProfileSetupViewModel();
}
