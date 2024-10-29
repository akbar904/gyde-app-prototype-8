import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:payment_method_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PaymentMethodView extends StackedView<PaymentMethodViewModel> {
  const PaymentMethodView({super.key});

  @override
  Widget builder(
      BuildContext context, PaymentMethodViewModel viewModel, Widget? child,) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(32),
              Text(
                'Payment Method',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold,),
              ),
              const Gap(8),
              Text(
                'Select your preferred payment method',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const Gap(32),
              _buildPaymentOptions(context, viewModel),
              const Spacer(),
              _buildContinueButton(context, viewModel),
              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOptions(
      BuildContext context, PaymentMethodViewModel viewModel,) {
    return Column(
      children: [
        _paymentOption(
            'Credit Card',
            Icons.credit_card,
            viewModel.selectedMethod == 'credit_card',
            () => viewModel.selectPaymentMethod('credit_card'),),
        const Gap(16),
        _paymentOption(
            'Apple Pay',
            Icons.apple,
            viewModel.selectedMethod == 'apple_pay',
            () => viewModel.selectPaymentMethod('apple_pay'),),
        const Gap(16),
        _paymentOption(
            'Bank Connection',
            Icons.account_balance,
            viewModel.selectedMethod == 'bank',
            () => viewModel.selectPaymentMethod('bank'),),
      ],
    );
  }

  Widget _paymentOption(
      String title, IconData icon, bool selected, VoidCallback onTap,) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: selected ? Colors.blue.withOpacity(0.1) : Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: selected ? Colors.blue : Colors.transparent,),),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const Gap(16),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Spacer(),
            if (selected) const Icon(Icons.check_circle, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(
      BuildContext context, PaymentMethodViewModel viewModel,) {
    return ElevatedButton(
      onPressed: viewModel.selectedMethod.isNotEmpty
          ? () => viewModel.continueToNextStep()
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Continue',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
      ),
    );
  }

  @override
  PaymentMethodViewModel viewModelBuilder(BuildContext context) =>
      PaymentMethodViewModel();
}
