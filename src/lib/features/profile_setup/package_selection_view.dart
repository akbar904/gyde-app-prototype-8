import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/profile_setup/package_selection_viewmodel.dart';
import 'package:my_app/ui/common/app_colors.dart';

class PackageSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PackageSelectionViewModel>.reactive(
      viewModelBuilder: () => PackageSelectionViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.darkBackground,
        appBar: AppBar(
          title: Text('Select Your Package'),
          backgroundColor: AppColors.darkPrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: model.packages
                .map((package) => _buildPackageCard(context, model, package))
                .toList(),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: model.selectedPackage != null
                ? model.proceedWithSelection
                : null,
            style: ElevatedButton.styleFrom(
              primary: AppColors.primaryAccent,
            ),
            child: Text('Proceed with Selection'),
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard(
      BuildContext context, PackageSelectionViewModel model, Package package) {
    return Card(
      color: AppColors.darkCard,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              package.name,
              style: TextStyle(
                color: AppColors.lightText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\$${package.price}/month',
              style: TextStyle(
                color: AppColors.primaryAccent,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              package.features.join(', '),
              style: TextStyle(
                color: AppColors.lightTextSecondary,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => model.selectPackage(package),
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryAccent,
              ),
              child: Text('Select Package'),
            ),
          ],
        ),
      ),
    );
  }
}
