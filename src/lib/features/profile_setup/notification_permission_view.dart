import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'notification_permission_viewmodel.dart';

class NotificationPermissionView
    extends StackedView<NotificationPermissionViewModel> {
  @override
  Widget builder(BuildContext context,
      NotificationPermissionViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),

              // Notification Icon
              SvgPicture.asset(
                'assets/icons/notification.svg',
                height: 120,
                width: 120,
              ),

              const SizedBox(height: 32),

              Text(
                'Stay Updated',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              Text(
                'Enable notifications to receive updates about your rides, chauffeur details and special offers.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              ElevatedButton(
                  onPressed: viewModel.requestNotificationPermission,
                  child: const Text('Enable Notifications')),

              const SizedBox(height: 16),

              TextButton(
                  onPressed: viewModel.skipNotifications,
                  child: const Text('Skip for Now')),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  @override
  NotificationPermissionViewModel viewModelBuilder(BuildContext context) =>
      NotificationPermissionViewModel();
}
