import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gap/gap.dart';

class WelcomeView extends StatelessWidget {
  static const routeName = '/welcome';

  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get Started',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                ),
                const Gap(20),
                Text(
                  'Experience luxury travel with ease. Register and manage your bookings seamlessly.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const Gap(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: model.navigateToAuthOptions,
                    child: const Text('Continue'),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => WelcomeViewModel(),
    );
  }
}

class WelcomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> navigateToAuthOptions() async {
    await _navigationService.navigateTo('/auth-options');
  }
}
