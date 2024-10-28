
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';

class EmailCollectionView extends StatelessWidget {
	const EmailCollectionView({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<EmailCollectionViewModel>.reactive(
			viewModelBuilder: () => EmailCollectionViewModel(),
			builder: (context, viewModel, child) {
				return Scaffold(
					backgroundColor: Theme.of(context).scaffoldBackgroundColor,
					body: SafeArea(
						child: Padding(
							padding: const EdgeInsets.symmetric(horizontal: 24.0),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									const Gap(40),
									Text(
										'Stay Connected',
										style: Theme.of(context).textTheme.headlineMedium?.copyWith(
											color: Colors.white,
											fontWeight: FontWeight.bold
										),
									),
									const Gap(12),
									Text(
										'To provide you with tailored services and updates, please share your email with us.',
										style: Theme.of(context).textTheme.bodyLarge?.copyWith(
											color: Colors.grey[400]
										),
									),
									const Gap(40),
									TextField(
										onChanged: (value) => viewModel.setEmail(value),
										decoration: InputDecoration(
											labelText: 'Email',
											border: OutlineInputBorder(
												borderRadius: BorderRadius.circular(8)
											),
											enabledBorder: OutlineInputBorder(
												borderRadius: BorderRadius.circular(8),
												borderSide: BorderSide(color: Colors.grey[800]!)
											),
											focusedBorder: OutlineInputBorder(
												borderRadius: BorderRadius.circular(8),
												borderSide: BorderSide(color: Theme.of(context).primaryColor)
											),
											filled: true,
											fillColor: Colors.grey[900],
											labelStyle: TextStyle(color: Colors.grey[400])
										),
										style: const TextStyle(color: Colors.white),
									),
									const Spacer(),
									SizedBox(
										width: double.infinity,
										height: 50,
										child: ElevatedButton(
											onPressed: viewModel.continue,
											style: ElevatedButton.styleFrom(
												backgroundColor: Theme.of(context).primaryColor,
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(8)
												)
											),
											child: const Text(
												'Continue',
												style: TextStyle(
													color: Colors.white,
													fontWeight: FontWeight.bold
												),
											),
										),
									),
									const Gap(40)
								],
							),
						),
					),
				);
			}
		);
	}
}

class EmailCollectionViewModel extends BaseViewModel {
	String _email = '';

	void setEmail(String email) {
		_email = email;
		notifyListeners();
	}

	void continue() {
		// TODO: Implement navigation to next screen
	}
}
