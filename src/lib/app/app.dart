import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:aorteq_app/features/authentication/login_view.dart';
import 'package:aorteq_app/features/study_plan/study_plan_view.dart';
import 'package:aorteq_app/features/question_bank/question_view.dart';
import 'package:aorteq_app/features/progress_tracking/progress_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView),
    MaterialRoute(page: StudyPlanView),
    MaterialRoute(page: QuestionView),
    MaterialRoute(page: ProgressView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
  ],
)
class App {}
