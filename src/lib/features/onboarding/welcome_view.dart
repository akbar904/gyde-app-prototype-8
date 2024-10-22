import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Gyde'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Experience luxury travel with ease. Register and manage your bookings seamlessly.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: model.navigateToAuthOptions,
                child: Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeViewModel extends BaseViewModel {
  void navigateToAuthOptions() {
    // Logic to navigate to the authentication options page
  }
}
