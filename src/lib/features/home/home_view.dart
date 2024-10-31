// Import necessary packages
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Import the ViewModel for the view
import 'package:com.com.walturn.aorteq_app/features/authentication/welcome_viewmodel.dart';

// Define the WelcomeView with the ViewModel
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
            children: <Widget>[
              // Google Sign-In Button
              ElevatedButton(
                onPressed: model.signInWithGoogle,
                child: Text('Sign in with Google'),
              ),
              SizedBox(height: 20),
              // Email Login Button
              ElevatedButton(
                onPressed: model.navigateToEmailAuth,
                child: Text('Login with Email'),
              ),
              SizedBox(height: 20),
              // Sign-Up Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to Sign-Up View if applicable
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
