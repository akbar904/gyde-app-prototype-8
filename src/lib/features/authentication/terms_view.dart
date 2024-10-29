import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/authentication/terms_viewmodel.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class TermsView extends StackedView<TermsViewModel> {
  const TermsView({super.key});

  @override
  Widget builder(
      BuildContext context, TermsViewModel viewModel, Widget? child,) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceLarge,
              const Text(
                'Terms & Conditions',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,),
              ),
              verticalSpaceMedium,
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    viewModel.termsText,
                    style: const TextStyle(color: Colors.white70, height: 1.5),
                  ),
                ),
              ),
              verticalSpaceMedium,
              Row(
                children: [
                  Checkbox(
                    value: viewModel.termsAccepted,
                    onChanged: viewModel.setTermsAccepted,
                    fillColor: WidgetStateProperty.all(AppColors.primary),
                  ),
                  const Text(
                    'I accept the terms and conditions',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              verticalSpaceMedium,
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      viewModel.termsAccepted ? viewModel.onContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }

  @override
  TermsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TermsViewModel();
}
