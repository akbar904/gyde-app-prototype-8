import 'package:gyde_app/features/onboarding/welcome/welcome_view.dart';
import 'package:gyde_app/features/onboarding/auth_options/auth_options_view.dart';
import 'package:gyde_app/features/onboarding/phone_input/phone_input_view.dart';
import 'package:gyde_app/features/onboarding/verification/verification_view.dart';
import 'package:gyde_app/features/onboarding/email_collection/email_collection_view.dart';
import 'package:gyde_app/features/onboarding/welcome_confirmation/welcome_confirmation_view.dart';
import 'package:gyde_app/features/onboarding/terms/terms_view.dart';
import 'package:gyde_app/features/startup/startup_view.dart';
import 'package:gyde_app/services/auth_service.dart';
import 'package:gyde_app/services/validation_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: WelcomeView),
    MaterialRoute(page: AuthOptionsView),
    MaterialRoute(page: PhoneInputView),
    MaterialRoute(page: VerificationView),
    MaterialRoute(page: EmailCollectionView),
    MaterialRoute(page: WelcomeConfirmationView),
    MaterialRoute(page: TermsView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: ValidationService),
  ],
)
class App {}
