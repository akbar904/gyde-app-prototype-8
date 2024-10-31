import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/luxury_car_interior.jpg',
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to Gyde',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your luxury chauffeur experience awaits.',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => model.navigateToWelcome(),
                      child: Text('Get Started'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
