import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/authentication/email_auth_viewmodel.dart';

class EmailAuthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmailAuthViewModel>.reactive(
      viewModelBuilder: () => EmailAuthViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Email Authentication'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: model.emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: model.onEmailChanged,
              ),
              SizedBox(height: 16),
              TextField(
                controller: model.passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: model.onPasswordChanged,
              ),
              SizedBox(height: 16),
              model.isBusy
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: model.canSubmit
                          ? () {
                              model.authenticate();
                            }
                          : null,
                      child: Text('Login'),
                    ),
              if (model.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    model.errorMessage!,
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
