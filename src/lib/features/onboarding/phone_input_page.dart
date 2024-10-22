import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PhoneInputPage extends ViewModelWidget {
  @override
  Widget build(BuildContext context, viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your phone number to get yourself verified and ready to start your ride.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next page, e.g., VerificationCodePage
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
