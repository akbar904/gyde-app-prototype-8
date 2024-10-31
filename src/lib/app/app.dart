import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:gyde_app/features/authentication/welcome_view.dart';
import 'package:gyde_app/features/authentication/email_auth_view.dart';
import 'package:gyde_app/features/authentication/user_info_view.dart';
import 'package:gyde_app/features/exam_selection/exam_selection_view.dart';
import 'package:gyde_app/features/exam_selection/topic_selection_view.dart';
import 'package:gyde_app/features/exam_selection/study_time_view.dart';
import 'package:gyde_app/features/exam_selection/exam_date_view.dart';
import 'package:gyde_app/features/study_plan/study_plan_view.dart';
import 'package:gyde_app/ui/dialogs/auth_dialog/auth_dialog.dart';
import 'package:gyde_app/ui/dialogs/confirm_dialog/confirm_dialog.dart';
import 'package:gyde_app/ui/bottom_sheets/exam_selection/exam_selection_sheet.dart';
import 'package:gyde_app/ui/bottom_sheets/study_time/study_time_sheet.dart';
import 'package:gyde_app/services/auth_service.dart';
import 'package:gyde_app/services/user_service.dart';
import 'package:gyde_app/services/study_plan_service.dart';
import 'package:gyde_app/services/analytics_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: WelcomeView, initial: true),
    MaterialRoute(page: EmailAuthView),
    MaterialRoute(page: UserInfoView),
    MaterialRoute(page: ExamSelectionView),
    MaterialRoute(page: TopicSelectionView),
    MaterialRoute(page: StudyTimeView),
    MaterialRoute(page: ExamDateView),
    MaterialRoute(page: StudyPlanView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: StudyPlanService),
    LazySingleton(classType: AnalyticsService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: ExamSelectionSheet),
    StackedBottomsheet(classType: StudyTimeSheet),
  ],
  dialogs: [
    StackedDialog(classType: AuthDialog),
    StackedDialog(classType: ConfirmDialog),
  ],
)
class App {}
