import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/features/authentication/login_viewmodel.dart';
import 'package:my_app/ui/components/custom_button.dart';
import 'package:my_app/ui/components/custom_input_field.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInputField(
                labelText: 'Email',
                onChanged: model.setEmail,
              ),
              SizedBox(height: 16),
              CustomInputField(
                labelText: 'Password',
                obscureText: true,
                onChanged: model.setPassword,
              ),
              SizedBox(height: 32),
              CustomButton(
                text: 'Login',
                onPressed: model.login,
                isBusy: model.isBusy,
              ),
              if (model.hasError)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    model.errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
