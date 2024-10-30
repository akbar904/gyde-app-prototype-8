import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'terms_viewmodel.dart';

class TermsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TermsViewModel>.reactive(
      viewModelBuilder: () => TermsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Terms and Conditions'),
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.termsText,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: model.acceptedTerms,
                        onChanged: (value) => model.toggleAcceptedTerms(),
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                      ),
                      Flexible(
                        child: Text(
                          'I agree to the terms and conditions',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: model.acceptedTerms ? model.acceptTerms : null,
            style: ElevatedButton.styleFrom(
              primary: model.acceptedTerms ? Colors.white : Colors.grey,
              onPrimary: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: Text('Accept Terms'),
          ),
        ),
      ),
    );
  }
}
