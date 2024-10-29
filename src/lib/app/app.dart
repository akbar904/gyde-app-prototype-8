import 'package:gyde_app/features/authentication/email_collection_view.dart';
import 'package:gyde_app/features/authentication/phone_verification_view.dart';
import 'package:gyde_app/features/authentication/splash_view.dart';
import 'package:gyde_app/features/authentication/terms_view.dart';
import 'package:gyde_app/features/authentication/welcome_view.dart';
import 'package:gyde_app/features/booking/hourly_booking_view.dart';
import 'package:gyde_app/features/booking/multi_stop_booking_view.dart';
import 'package:gyde_app/features/booking/one_way_booking_view.dart';
import 'package:gyde_app/features/home/home_view.dart';
import 'package:gyde_app/features/profile_setup/mode_selection_view.dart';
import 'package:gyde_app/features/profile_setup/notification_permission_view.dart';
import 'package:gyde_app/features/profile_setup/package_selection_view.dart';
import 'package:gyde_app/features/profile_setup/payment_method_view.dart';
import 'package:gyde_app/features/profile_setup/profile_information_view.dart';
import 'package:gyde_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:gyde_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: WelcomeView),
    MaterialRoute(page: PhoneVerificationView),
    MaterialRoute(page: EmailCollectionView),
    MaterialRoute(page: TermsView),
    MaterialRoute(page: ModeSelectionView),
    MaterialRoute(page: ProfileInformationView),
    MaterialRoute(page: PackageSelectionView),
    MaterialRoute(page: PaymentMethodView),
    MaterialRoute(page: NotificationPermissionView),
    MaterialRoute(page: OneWayBookingView),
    MaterialRoute(page: MultiStopBookingView),
    MaterialRoute(page: HourlyBookingView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // Auth services will be added
    // Location services will be added
    // Payment services will be added
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
  ],
)
class App {}
