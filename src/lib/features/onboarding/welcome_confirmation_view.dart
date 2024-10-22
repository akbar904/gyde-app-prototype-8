
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gap/gap.dart';
import '../../../app/app.router.dart';
import '../../../app/app.locator.dart';

class WelcomeConfirmationView extends StatelessWidget {
	final _navigationService = locator<NavigationService>();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: Padding(
					padding: const EdgeInsets.symmetric(horizontal: 25.0),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							const Gap(40),
							const Text(
								'Welcome Aboard!',
								style: TextStyle(
									fontSize: 28,
									fontWeight: FontWeight.bold,
								),
							),
							const Gap(20),
							const Text(
								'You've unlocked access to exclusive, personalized chauffeur services with Gyde.',
								style: TextStyle(
									fontSize: 16,
								),
							),
							const Gap(20),
							const Text(
								'Experience comfort, Tailored to your needs',
								style: TextStyle(
									fontSize: 16,
									fontStyle: FontStyle.italic,
								),
							),
							const Spacer(),
							SizedBox(
								width: double.infinity,
								height: 50,
								child: ElevatedButton(
									onPressed: () {
										_navigationService.navigateToTermsConditionsView();
									},
									child: const Text('Continue'),
								),
							),
							const Gap(20),
						],
					),
				),
			),
		);
	}
}
