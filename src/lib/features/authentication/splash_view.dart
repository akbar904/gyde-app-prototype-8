import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/authentication/splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.navigateToWelcome(),
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_car,
                  size: 100,
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome to Gyde',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 10),
                Text(
                  'Experience luxury travel with ease.',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  'Register and manage your bookings seamlessly.',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
