import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'welcome_viewmodel.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Aorteq'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Aorteq',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                'Your Ultimate Medical Study Companion',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: model.signInWithGoogle,
                child: Text('Continue with Google'),
              ),
              TextButton(
                onPressed: model.navigateToEmailAuth,
                child: Text('Login with Email'),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to sign-up screen
                },
                child: Text('Sign Up'),
              ),
              Spacer(),
              Text(
                'By continuing, you agree to our Terms and Privacy Policy.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
