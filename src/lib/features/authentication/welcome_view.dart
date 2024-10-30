import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'welcome_viewmodel.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  'Experience luxury travel with ease.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Register and manage your bookings seamlessly.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await _showAuthenticationOptions(context, model);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAuthenticationOptions(
      BuildContext context, WelcomeViewModel model) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone Verification'),
            onTap: () async {
              Navigator.pop(context);
              await model.navigateToPhoneVerification();
            },
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email Collection'),
            onTap: () async {
              Navigator.pop(context);
              await model.navigateToEmailCollection();
            },
          ),
        ],
      ),
    );
  }
}
