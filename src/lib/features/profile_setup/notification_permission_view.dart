import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'notification_permission_viewmodel.dart';

class NotificationPermissionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationPermissionViewModel>.reactive(
      viewModelBuilder: () => NotificationPermissionViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Enable Notifications'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Stay Informed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Enable notifications to receive updates about your rides and exclusive offers.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await model.requestNotificationPermission();
                  },
                  child: Text('Allow Notifications'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Assuming skipPermissionRequest is a method in the ViewModel
                    model.skipPermissionRequest();
                  },
                  child: Text(
                    'Skip for now',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
