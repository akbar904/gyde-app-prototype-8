import 'package:gyde_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:gyde_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:gyde_app/features/startup/startup_view.dart';
import 'package:gyde_app/features/onboarding/welcome_page.dart';
import 'package:gyde_app/features/onboarding/auth_options_page.dart';
import 'package:gyde_app/features/onboarding/phone_input_page.dart';
import 'package:gyde_app/features/onboarding/verification_code_page.dart';
import 'package:gyde_app/features/onboarding/email_collection_page.dart';
import 'package:gyde_app/features/onboarding/welcome_confirmation_page.dart';
import 'package:gyde_app/features/onboarding/terms_conditions_page.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: WelcomePage),
    MaterialRoute(page: AuthOptionsPage),
    MaterialRoute(page: PhoneInputPage),
    MaterialRoute(page: VerificationCodePage),
    MaterialRoute(page: EmailCollectionPage),
    MaterialRoute(page: WelcomeConfirmationPage),
    MaterialRoute(page: TermsConditionsPage),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
