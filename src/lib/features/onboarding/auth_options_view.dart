import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AuthOptionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactiveViewModel(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Authentication'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Choose your authentication method',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to PhoneInputView
                },
                child: Text('Continue with Phone'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Navigate to EmailCollectionView
                },
                child: Text('Continue with Email'),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AuthOptionsViewModel(),
    );
  }
}

class AuthOptionsViewModel extends BaseViewModel {
  // Add any necessary logic for the AuthOptionsViewModel here
}
