import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import '../profile_setup_viewmodel.dart';

class PaymentMethodView extends ViewModelBuilderWidget<ProfileSetupViewModel> {
  @override
  Widget builder(
      BuildContext context, ProfileSetupViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Payment Method',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Gap(8),
              const Text(
                'Add your preferred payment method securely.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Gap(32),
              _buildPaymentOption('Credit or Debit Card', Icons.credit_card,
                  () => viewModel.onCreditCardSelected()),
              const Gap(16),
              _buildPaymentOption('Apple Pay', Icons.apple,
                  () => viewModel.onApplePaySelected()),
              if (viewModel.isBusinessMode)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _buildPaymentOption(
                      'Connect to Bank',
                      Icons.account_balance,
                      () => viewModel.onConnectBankSelected()),
                ),
              const Spacer(),
              ElevatedButton(
                onPressed: viewModel.onAddPaymentMethodPressed,
                child: const Text('Add Payment Method'),
              ),
              const Gap(16),
              TextButton(
                onPressed: viewModel.onSkipForNowPressed,
                child: const Text('Skip for Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon),
            const Gap(16),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ProfileSetupViewModel viewModelBuilder(BuildContext context) =>
      ProfileSetupViewModel();
}
