import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TermsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TermsViewModel>.reactive(
      viewModelBuilder: () => TermsViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terms & Conditions',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                Text(
                  'Please read our terms and conditions carefully',
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      _termsText,
                      style: TextStyle(color: Colors.grey[300], height: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: model.onAcceptTerms,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text('Accept & Continue'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TermsViewModel extends BaseViewModel {
  void onAcceptTerms() {
    // Navigate to next screen after terms acceptance
  }
}

const _termsText = '''
1. Acceptance of Terms
By accessing and using the Gyde luxury chauffeur service, you agree to be bound by these Terms and Conditions.

2. Service Description
Gyde provides luxury chauffeur services through its mobile application platform. Services include one-way trips, hourly bookings, and multi-stop journeys.

3. User Registration
Users must provide accurate and complete information during registration. You are responsible for maintaining the confidentiality of your account.

4. Booking and Cancellation
- Bookings must be made at least 2 hours in advance
- Cancellations made within 1 hour of scheduled pickup incur a 50% charge
- No-shows will be charged the full fare

5. Payment Terms
- Payment is required at the time of booking
- All prices are in USD unless otherwise stated
- Additional charges may apply for waiting time, extra stops, or special requests

6. User Conduct
Users agree to:
- Treat chauffeurs and vehicles with respect
- Not engage in illegal activities
- Provide accurate pickup and drop-off information
- Follow safety guidelines

7. Privacy Policy
Your privacy is important to us. Please review our Privacy Policy for information on how we collect and use your data.

8. Liability
Gyde is not liable for:
- Personal belongings left in vehicles
- Delays due to traffic or weather conditions
- Indirect or consequential losses

9. Modifications
We reserve the right to modify these terms at any time. Continued use of the service constitutes acceptance of modified terms.

10. Governing Law
These terms are governed by the laws of the United States.
''';
