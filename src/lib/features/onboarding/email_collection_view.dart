import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';

class EmailCollectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmailCollectionViewModel>.reactive(
      viewModelBuilder: () => EmailCollectionViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Stay Connected'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'To provide you with tailored services and updates, please share your email with us.',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const Gap(20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: model.updateEmail,
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () => model.onNext(context),
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailCollectionViewModel extends BaseViewModel {
  String _email = '';

  void updateEmail(String email) {
    _email = email;
  }

  void onNext(BuildContext context) {
    // Add logic to handle the email submission if needed
    Navigator.of(context).pushNamed('/welcomeConfirmation');
  }
}
