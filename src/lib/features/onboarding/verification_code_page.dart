import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class VerificationCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerificationCodeViewModel>.reactive(
      viewModelBuilder: () => VerificationCodeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Verification'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Code',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 16),
              Text(
                'We sent a verification code to your phone number +65 8123 4567',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
                keyboardType: TextInputType.number,
                onChanged: model.onCodeChanged,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: model.canSubmit ? model.verifyCode : null,
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VerificationCodeViewModel extends BaseViewModel {
  String _code = '';

  void onCodeChanged(String code) {
    _code = code;
    notifyListeners();
  }

  bool get canSubmit => _code.isNotEmpty;

  void verifyCode() {
    // Logic to verify the code
  }
}
