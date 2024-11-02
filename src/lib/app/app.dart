import 'package:gyde_app/features/authentication/login_view.dart';
import 'package:gyde_app/features/study_plan/study_plan_view.dart';
import 'package:gyde_app/features/question_bank/question_view.dart';
import 'package:gyde_app/features/progress_tracking/progress_dashboard_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView),
    MaterialRoute(page: StudyPlanView),
    MaterialRoute(page: QuestionView),
    MaterialRoute(page: ProgressDashboardView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    // Define any bottomsheets if necessary
    // @stacked-bottom-sheet
  ],
  dialogs: [
    // Define any dialogs if necessary
    // @stacked-dialog
  ],
)
class App {}
