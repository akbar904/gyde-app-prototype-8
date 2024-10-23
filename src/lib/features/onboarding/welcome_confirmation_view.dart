
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import '../onboarding_viewmodel.dart';

class WelcomeConfirmationView extends StackedView<OnboardingViewModel> {
	@override
	Widget builder(BuildContext context, OnboardingViewModel viewModel, Widget? child) {
		return Scaffold(
			body: SafeArea(
				child: Padding(
					padding: const EdgeInsets.symmetric(horizontal: 24),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							const Spacer(),
							Text(
								'Welcome Aboard!',
								style: Theme.of(context).textTheme.headlineMedium?.copyWith(
									fontWeight: FontWeight.bold
								),
							),
							const Gap(24),
							Text(
								'You've unlocked access to exclusive, personalized chauffeur services with Gyde.',
								textAlign: TextAlign.center,
								style: Theme.of(context).textTheme.bodyLarge,
							),
							const Gap(16),
							Text(
								'Experience comfort, Tailored to your needs',
								textAlign: TextAlign.center,
								style: Theme.of(context).textTheme.bodyLarge,
							),
							const Spacer(),
							SizedBox(
								width: double.infinity,
								child: ElevatedButton(
									onPressed: () => viewModel.navigateToTermsConditions(),
									child: const Text('Continue'),
								),
							),
							const Gap(24),
						],
					),
				),
			),
		);
	}

	@override
	OnboardingViewModel viewModelBuilder(BuildContext context) => OnboardingViewModel();
}
