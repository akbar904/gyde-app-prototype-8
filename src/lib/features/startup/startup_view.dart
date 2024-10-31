
// email_auth_view.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'email_auth_viewmodel.dart';
import 'package:gap/gap.dart';

class EmailAuthView extends StackedView<EmailAuthViewModel> {
  const EmailAuthView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, EmailAuthViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
              onChanged: (value) {
                viewModel.validateEmail(value);
              },
              keyboardType: TextInputType.emailAddress,
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: viewModel.isBusy 
                ? null 
                : () => viewModel.sendVerificationCode(),
              child: viewModel.isBusy
                ? const CircularProgressIndicator()
                : const Text('Send Verification Code'),
            ),
            if (viewModel.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  viewModel.error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  EmailAuthViewModel viewModelBuilder(BuildContext context) => EmailAuthViewModel();
}

// email_auth_viewmodel.dart
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';

class EmailAuthViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  String? _email;
  
  bool validateEmail(String email) {
    _email = email;
    final emailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    notifyListeners();
    return emailValid;
  }

  Future<void> sendVerificationCode() async {
    if (_email == null || !validateEmail(_email!)) {
      setError('Please enter a valid email');
      return;
    }

    setBusy(true);
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Navigate to user info on success
      await _navigationService.navigateTo(Routes.userInfoView);
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }
}
