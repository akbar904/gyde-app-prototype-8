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
          title: Text('Aorteq', style: Theme.of(context).textTheme.headline6),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'Your Ultimate Medical Study Companion',
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32.0),
              if (model.isBusy)
                Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: model.continueWithGoogle,
                  child: Text('Continue with Google'),
                ),
              TextButton(
                onPressed: model.loginWithEmail,
                child: Text('Login with Email'),
              ),
              TextButton(
                onPressed: model.signUp,
                child: Text('Sign Up'),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: model.showTermsAndPrivacy,
                child: Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy.',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
