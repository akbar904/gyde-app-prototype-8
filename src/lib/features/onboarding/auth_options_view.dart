import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';

class AuthOptionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AuthOptionsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Gyde'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Choose an option to continue',
                style: Theme.of(context).textTheme.headline6,
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () => model.navigateToPhoneInput(),
                child: const Text('Continue with Phone'),
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () => model.navigateToEmailCollection(),
                child: const Text('Continue with Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthOptionsViewModel extends BaseViewModel {
  void navigateToPhoneInput() {
    // Logic to navigate to the phone input page
  }

  void navigateToEmailCollection() {
    // Logic to navigate to the email collection page
  }
}
