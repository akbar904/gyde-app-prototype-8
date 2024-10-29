import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'mode_selection_viewmodel.dart';

class ModeSelectionView extends StackedView<ModeSelectionViewModel> {
  const ModeSelectionView({super.key});

  @override
  Widget builder(
      BuildContext context, ModeSelectionViewModel viewModel, Widget? child,) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Your Mode',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please let us know which account type suits you best.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 48),
              GestureDetector(
                onTap: () => viewModel.selectBusinessMode(),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: viewModel.selectedMode == 'business'
                              ? Colors.white
                              : Colors.transparent,
                          width: 2,),),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.business,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Business Mode',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => viewModel.selectPersonalMode(),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: viewModel.selectedMode == 'personal'
                              ? Colors.white
                              : Colors.transparent,
                          width: 2,),),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Personal Mode',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),),),
                  onPressed: viewModel.selectedMode != null
                      ? viewModel.continueToNextStep
                      : null,
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ModeSelectionViewModel viewModelBuilder(BuildContext context) =>
      ModeSelectionViewModel();
}
