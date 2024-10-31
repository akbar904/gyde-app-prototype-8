import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/authentication/splash_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display luxury car interior image
              Image.asset('assets/images/luxury_car_interior.png'),
              SizedBox(height: 20),
              // Display splash screen loading indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
