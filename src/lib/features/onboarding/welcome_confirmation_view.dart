import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WelcomeConfirmationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeConfirmationViewModel>.reactive(
      viewModelBuilder: () => WelcomeConfirmationViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Gyde'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Aboard!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "You've unlocked access to exclusive, personalized chauffeur services with Gyde.",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Experience comfort, Tailored to your needs',
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    model.navigateToTermsConditions();
                  },
                  child: Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeConfirmationViewModel extends BaseViewModel {
  void navigateToTermsConditions() {
    // Logic to navigate to the Terms and Conditions page
  }
}
