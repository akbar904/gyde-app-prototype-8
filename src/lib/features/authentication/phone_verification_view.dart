import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';
import 'phone_verification_viewmodel.dart';

class PhoneVerificationView extends StackedView<PhoneVerificationViewModel> {
  const PhoneVerificationView({super.key});

  @override
  Widget builder(BuildContext context, PhoneVerificationViewModel viewModel,
      Widget? child,) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40),
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: viewModel.navigateBack,
              ),
              const Gap(24),
              if (!viewModel.isVerificationMode) ...[
                const Text(
                  'Add Your Phone',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,),
                ),
                const Gap(8),
                const Text(
                  'Enter your phone number to get yourself verified and ready to start your ride.',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const Gap(32),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    viewModel.updatePhoneNumber(number.phoneNumber ?? '');
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN,
                  ),
                  initialValue: PhoneNumber(isoCode: 'US'),
                  formatInput: true,
                  keyboardType: TextInputType.phone,
                  inputDecoration: const InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  textStyle: const TextStyle(color: Colors.white),
                ),
                const Gap(32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: viewModel.verifyPhoneNumber,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Verify Phone Number',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,),
                    ),
                  ),
                ),
              ] else ...[
                const Text(
                  'Enter Code',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,),
                ),
                const Gap(8),
                Text(
                  'We sent verification code to your phone number ${viewModel.phoneNumber}',
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const Gap(32),
                Pinput(
                  length: 6,
                  onCompleted: viewModel.updateVerificationCode,
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const Gap(32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: viewModel.submitVerificationCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Verify Code',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,),
                    ),
                  ),
                ),
                const Gap(16),
                Center(
                  child: TextButton(
                    onPressed: viewModel.resendCode,
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  PhoneVerificationViewModel viewModelBuilder(BuildContext context) =>
      PhoneVerificationViewModel();
}
