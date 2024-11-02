import 'package:gyde_app/features/authentication/login_view.dart';
import 'package:gyde_app/features/study_plan/study_plan_view.dart';
import 'package:gyde_app/features/progress_tracking/progress_dashboard_view.dart';
import 'package:gyde_app/features/question_bank/question_view.dart';
import 'package:gyde_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:gyde_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView),
    MaterialRoute(page: StudyPlanView),
    MaterialRoute(page: ProgressDashboardView),
    MaterialRoute(page: QuestionView),
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
