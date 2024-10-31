import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'welcome_viewmodel.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      viewModelBuilder: () => WelcomeViewModel(
        navigationService: NavigationService(),
        dialogService: DialogService(),
      ),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Aorteq'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Aorteq',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 4.0),
              Text(
                'Your Ultimate Medical Study Companion',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: model.continueWithGoogle,
                child: Text('Continue with Google'),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: model.navigateToEmailAuth,
                child: Text('Login with Email'),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: model.signUp,
                child: Text('Sign Up'),
              ),
              Spacer(),
              Text(
                'By continuing, you agree to our Terms and Privacy Policy.',
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: model.showTermsAndPrivacyPolicy,
                child: Text('View Terms and Privacy Policy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
