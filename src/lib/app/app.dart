import 'package:aorteq_app/features/authentication/welcome_view.dart';
import 'package:aorteq_app/features/authentication/email_auth_view.dart';
import 'package:aorteq_app/features/authentication/user_info_view.dart';
import 'package:aorteq_app/features/exam_selection/exam_selection_view.dart';
import 'package:aorteq_app/features/exam_selection/topic_selection_view.dart';
import 'package:aorteq_app/features/exam_selection/study_time_view.dart';
import 'package:aorteq_app/features/exam_selection/exam_date_view.dart';
import 'package:aorteq_app/features/study_plan/study_plan_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

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
  ],
)
class App {}
