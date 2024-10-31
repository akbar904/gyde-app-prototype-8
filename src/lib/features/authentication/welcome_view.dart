import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'welcome_viewmodel.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      viewModelBuilder: () => WelcomeViewModel(
        navigationService: StackedService.locator<NavigationService>(),
      ),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Aorteq'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Text(
                      'Aorteq',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Your Ultimate Medical Study Companion',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {
                  await model.continueWithGoogle();
                  // Additional logic for handling post-authentication can be added here
                },
                child: Text('Continue with Google'),
              ),
              TextButton(
                onPressed: () async {
                  await model.loginWithEmail();
                  // Additional logic for handling post-authentication can be added here
                },
                child: Text('Login with Email'),
              ),
              TextButton(
                onPressed: () async {
                  await model.signUp();
                  // Additional logic for handling post-signup can be added here
                },
                child: Text('Sign Up'),
              ),
              Spacer(),
              Text(
                'By continuing, you agree to our Terms and Privacy Policy',
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
