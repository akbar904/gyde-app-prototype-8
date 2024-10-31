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
          title: Text('Welcome'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Experience luxury travel with ease. Register and manage your bookings seamlessly.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: model.navigateToAuthOptions,
                child: Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
