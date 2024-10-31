
// lib/features/authentication/welcome_view.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:aorteq_app/features/authentication/welcome_viewmodel.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Aorteq'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to your medical study companion!',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: model.navigateToEmailAuth,
                child: Text('Login with Email'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: model.navigateToUserInfo,
                child: Text('Continue as Guest'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// lib/features/authentication/welcome_viewmodel.dart
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:aorteq_app/app/app.locator.dart';
import 'package:aorteq_app/app/app.router.dart';

class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToEmailAuth() {
    _navigationService.navigateTo(Routes.emailAuthView);
  }

  void navigateToUserInfo() {
    _navigationService.navigateTo(Routes.userInfoView);
  }
}
