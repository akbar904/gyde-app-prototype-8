import 'package:aorteq_app/features/authentication/email_auth_view.dart';
import 'package:aorteq_app/features/authentication/user_info_view.dart';
import 'package:aorteq_app/features/authentication/welcome_view.dart';
import 'package:aorteq_app/features/study_planning/exam_date_view.dart';
import 'package:aorteq_app/features/study_planning/exam_selection_view.dart';
import 'package:aorteq_app/features/study_planning/study_time_view.dart';
import 'package:aorteq_app/features/study_planning/topic_selection_view.dart';
import 'package:aorteq_app/features/study_plan/plan_generation_view.dart';
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
    MaterialRoute(page: PlanGenerationView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
  ],
)
class App {}
