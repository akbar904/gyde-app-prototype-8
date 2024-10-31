import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import './email_auth_viewmodel.dart';

class EmailAuthView extends StackedView<EmailAuthViewModel> {
  const EmailAuthView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EmailAuthViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email address',
                hintText: 'Enter your email address',
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => viewModel.setEmail(value),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.isValidEmail
                  ? () => viewModel.sendVerificationCode()
                  : null,
              child: const Text('Continue'),
            ),
            if (viewModel.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  viewModel.errorMessage,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ),
            if (viewModel.isBusy)
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  EmailAuthViewModel viewModelBuilder(BuildContext context) =>
      EmailAuthViewModel();
}
