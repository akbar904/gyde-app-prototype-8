import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../shared/app_colors.dart';
import '../../shared/ui_helpers.dart';
import 'welcome_viewmodel.dart';

class WelcomeView extends StackedView<WelcomeViewModel> {
  @override
  Widget builder(
      BuildContext context, WelcomeViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                'Gyde',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpaceLarge,
              Text(
                'Experience luxury travel with ease. Register and manage your bookings seamlessly.',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: viewModel.navigateToAuthOptions,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }

  @override
  WelcomeViewModel viewModelBuilder(BuildContext context) => WelcomeViewModel();
}
