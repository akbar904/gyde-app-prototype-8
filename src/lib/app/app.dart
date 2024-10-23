import 'package:gyde_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:gyde_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:gyde_app/features/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gyde_app/features/onboarding/welcome_view.dart';
import 'package:gyde_app/features/onboarding/auth_options_view.dart';
import 'package:gyde_app/features/onboarding/phone_input_view.dart';
import 'package:gyde_app/features/onboarding/verification_code_view.dart';
import 'package:gyde_app/features/onboarding/email_collection_view.dart';
import 'package:gyde_app/features/onboarding/welcome_confirmation_view.dart';
import 'package:gyde_app/features/onboarding/terms_conditions_view.dart';
import 'package:gyde_app/features/home/main_rides_view.dart';
import 'package:gyde_app/features/home/chauffeur_details_view.dart';
import 'package:gyde_app/features/home/profile_view.dart';
import 'package:gyde_app/features/profile_setup/mode_selection_view.dart';
import 'package:gyde_app/features/profile_setup/personal_info_view.dart';
import 'package:gyde_app/features/profile_setup/company_info_view.dart';
import 'package:gyde_app/features/profile_setup/package_selection_view.dart';
import 'package:gyde_app/features/profile_setup/payment_method_view.dart';
import 'package:gyde_app/features/profile_setup/card_details_view.dart';
import 'package:gyde_app/features/profile_setup/notification_permission_view.dart';
import 'package:gyde_app/features/profile_setup/profile_completion_view.dart';
import 'package:gyde_app/services/theme_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: WelcomeView),
    MaterialRoute(page: AuthOptionsView),
    MaterialRoute(page: PhoneInputView),
    MaterialRoute(page: VerificationCodeView),
    MaterialRoute(page: EmailCollectionView),
    MaterialRoute(page: WelcomeConfirmationView),
    MaterialRoute(page: TermsConditionsView),
    MaterialRoute(page: MainRidesView),
    MaterialRoute(page: ChauffeurDetailsView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: ModeSelectionView),
    MaterialRoute(page: PersonalInfoView),
    MaterialRoute(page: CompanyInfoView),
    MaterialRoute(page: PackageSelectionView),
    MaterialRoute(page: PaymentMethodView),
    MaterialRoute(page: CardDetailsView),
    MaterialRoute(page: NotificationPermissionView),
    MaterialRoute(page: ProfileCompletionView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ThemeService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
  ],
)
class App {}
