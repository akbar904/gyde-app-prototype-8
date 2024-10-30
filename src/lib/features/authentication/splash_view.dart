import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/luxury_car_interior.jpg',
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 50.0,
                  left: 0.0,
                  right: 0.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Gyde',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Experience luxury travel with ease.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () async {
                          await model.initialize();
                          model.navigateToWelcome();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
