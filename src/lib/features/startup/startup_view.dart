import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/authentication/splash_viewmodel.dart';

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
            child: model.isBusy
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/luxury_car_interior.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Welcome to Gyde',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
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
