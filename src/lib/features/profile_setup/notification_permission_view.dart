import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NotificationPermissionView extends StatelessWidget {
  const NotificationPermissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationPermissionViewModel>.reactive(
      viewModelBuilder: () => NotificationPermissionViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/notification_icon.png',
                  height: 120,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Enable Notifications',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Stay updated with your ride status and chauffeur details by enabling notifications',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: viewModel.requestNotificationPermission,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Enable Notifications',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: viewModel.skipNotificationPermission,
                  child: const Text(
                    'Skip for Now',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationPermissionViewModel extends BaseViewModel {
  void requestNotificationPermission() {
    // Request notification permission logic
  }

  void skipNotificationPermission() {
    // Skip permission and navigate to next screen
  }
}
