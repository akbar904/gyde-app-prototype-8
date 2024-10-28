import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class PaymentMethodView extends StackedView<PaymentMethodViewModel> {
  @override
  Widget builder(
      BuildContext context, PaymentMethodViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Add Payment Method',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Select your preferred payment method to continue',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              _buildPaymentOptions(viewModel),
              const SizedBox(height: 40),
              if (viewModel.selectedPaymentMethod == 'Credit Card')
                _buildCreditCardForm(viewModel),
              const Spacer(),
              _buildTermsCheckbox(viewModel),
              const SizedBox(height: 20),
              _buildContinueButton(viewModel),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOptions(PaymentMethodViewModel viewModel) {
    return Column(
      children: [
        _PaymentOptionCard(
          title: 'Credit Card',
          icon: Icons.credit_card,
          isSelected: viewModel.selectedPaymentMethod == 'Credit Card',
          onTap: () => viewModel.selectPaymentMethod('Credit Card'),
        ),
        const SizedBox(height: 16),
        _PaymentOptionCard(
          title: 'Apple Pay',
          icon: Icons.apple,
          isSelected: viewModel.selectedPaymentMethod == 'Apple Pay',
          onTap: () => viewModel.selectPaymentMethod('Apple Pay'),
        ),
        const SizedBox(height: 16),
        _PaymentOptionCard(
          title: 'Bank Connection',
          icon: Icons.account_balance,
          isSelected: viewModel.selectedPaymentMethod == 'Bank Connection',
          onTap: () => viewModel.selectPaymentMethod('Bank Connection'),
        ),
      ],
    );
  }

  Widget _buildCreditCardForm(PaymentMethodViewModel viewModel) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Card Number',
            labelStyle: TextStyle(color: Colors.grey[400]),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: viewModel.setCardNumber,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700]!),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: viewModel.setExpiryDate,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'CVV',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700]!),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: viewModel.setCvv,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox(PaymentMethodViewModel viewModel) {
    return Row(
      children: [
        Checkbox(
          value: viewModel.termsAccepted,
          onChanged: (value) => viewModel.setTermsAccepted(value ?? false),
          fillColor: MaterialStateProperty.all(Colors.white),
        ),
        Expanded(
          child: Text(
            'I accept the terms and conditions',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(PaymentMethodViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: viewModel.canContinue ? viewModel.onContinue : null,
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  PaymentMethodViewModel viewModelBuilder(BuildContext context) =>
      PaymentMethodViewModel();
}

class _PaymentOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentOptionCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.grey[700]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[400],
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodViewModel extends BaseViewModel {
  String? selectedPaymentMethod;
  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';
  bool termsAccepted = false;

  void selectPaymentMethod(String method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  void setCardNumber(String value) {
    cardNumber = value;
    notifyListeners();
  }

  void setExpiryDate(String value) {
    expiryDate = value;
    notifyListeners();
  }

  void setCvv(String value) {
    cvv = value;
    notifyListeners();
  }

  void setTermsAccepted(bool value) {
    termsAccepted = value;
    notifyListeners();
  }

  bool get canContinue {
    if (!termsAccepted) return false;
    if (selectedPaymentMethod == null) return false;
    if (selectedPaymentMethod == 'Credit Card') {
      return cardNumber.isNotEmpty && expiryDate.isNotEmpty && cvv.isNotEmpty;
    }
    return true;
  }

  Future<void> onContinue() async {
    // Handle payment method submission
  }
}
