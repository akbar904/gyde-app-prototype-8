import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../profile_setup_viewmodel.dart';

class NotificationPermissionView
    extends ViewModelWidget<ProfileSetupViewModel> {
  const NotificationPermissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileSetupViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Text(
                'Get Notified',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Ensure a seamless travel experience by allowing notifications.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: viewModel.handleNotificationPermission,
                child: const Text('Turn On Notifications'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: viewModel.skipNotifications,
                child: const Text('Not Right Now'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
