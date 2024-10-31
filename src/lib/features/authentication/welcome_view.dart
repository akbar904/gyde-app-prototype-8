import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:aorteq_app/features/authentication/welcome_viewmodel.dart';

class WelcomeView extends StackedView<WelcomeViewModel> {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WelcomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and branding
              Icon(
                Icons.medical_services,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Aorteq',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Your Ultimate Medical Study Companion',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Authentication buttons
              if (viewModel.isBusy)
                const CircularProgressIndicator()
              else
                Column(
                  children: [
                    FilledButton.icon(
                      onPressed: viewModel.signInWithGoogle,
                      icon: const Icon(Icons.g_mobiledata),
                      label: const Text('Continue with Google'),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: viewModel.navigateToEmailAuth,
                      child: const Text('Login with Email'),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: viewModel.navigateToEmailAuth,
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),

              if (viewModel.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    viewModel.error.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Terms and Privacy
              const Spacer(),
              Text(
                'By continuing you agree to our Terms of Service and Privacy Policy',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  WelcomeViewModel viewModelBuilder(BuildContext context) => WelcomeViewModel();
}
