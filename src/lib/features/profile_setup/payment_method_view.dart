import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/profile_setup/payment_method_viewmodel.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class PaymentMethodView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentMethodViewModel>.reactive(
      viewModelBuilder: () => PaymentMethodViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title:
                Text('Payment Method', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Payment Method',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                verticalSpaceMedium,
                _buildPaymentOption(
                  context,
                  icon: Icons.credit_card,
                  title: 'Credit Card',
                  onTap: () =>
                      model.selectPaymentMethod(PaymentMethod.CreditCard),
                ),
                verticalSpaceSmall,
                _buildPaymentOption(
                  context,
                  icon: Icons.apple,
                  title: 'Apple Pay',
                  onTap: () =>
                      model.selectPaymentMethod(PaymentMethod.ApplePay),
                ),
                verticalSpaceSmall,
                _buildPaymentOption(
                  context,
                  icon: Icons.account_balance,
                  title: 'Bank Connection',
                  onTap: () =>
                      model.selectPaymentMethod(PaymentMethod.BankConnection),
                ),
                verticalSpaceMedium,
                if (model.selectedMethod != null)
                  _buildPaymentDetailsForm(context, model),
                verticalSpaceMedium,
                ElevatedButton(
                  onPressed: model.validatePaymentDetails()
                      ? model.processPayment
                      : null,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black,
        );
      },
    );
  }

  Widget _buildPaymentOption(BuildContext context,
      {IconData icon, String title, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            horizontalSpaceSmall,
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsForm(
      BuildContext context, PaymentMethodViewModel model) {
    switch (model.selectedMethod) {
      case PaymentMethod.CreditCard:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Card Number',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  model.setCardDetails(value, model.expiryDate, model.cvv),
            ),
            verticalSpaceSmall,
            TextField(
              decoration: InputDecoration(
                labelText: 'Expiry Date',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.datetime,
              onChanged: (value) =>
                  model.setCardDetails(model.cardNumber, value, model.cvv),
            ),
            verticalSpaceSmall,
            TextField(
              decoration: InputDecoration(
                labelText: 'CVV',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => model.setCardDetails(
                  model.cardNumber, model.expiryDate, value),
            ),
            verticalSpaceSmall,
            CheckboxListTile(
              title: Text(
                'Accept Terms and Conditions',
                style: TextStyle(color: Colors.white),
              ),
              value: model.termsAccepted,
              onChanged: model.acceptTerms,
              checkColor: Colors.black,
              activeColor: Colors.white,
            ),
          ],
        );
      case PaymentMethod.ApplePay:
      case PaymentMethod.BankConnection:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details for ${model.selectedMethod.toString().split('.').last}',
              style: TextStyle(color: Colors.white),
            ),
            verticalSpaceSmall,
            CheckboxListTile(
              title: Text(
                'Accept Terms and Conditions',
                style: TextStyle(color: Colors.white),
              ),
              value: model.termsAccepted,
              onChanged: model.acceptTerms,
              checkColor: Colors.black,
              activeColor: Colors.white,
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
