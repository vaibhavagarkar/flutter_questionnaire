import 'package:get/get.dart';

import '../domain/models/questionnaire.dart';
import '../domain/usecases/get_questionnaires_use_case.dart';
import '../domain/usecases/get_user_submissions_use_case.dart';
import '../domain/usecases/save_questionnaire_submission_use_case.dart';
import '../modules/auth/controllers/auth_controller.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/auth/views/register_screen.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/profile/controllers/profile_controller.dart';
import '../modules/profile/views/profile_screen.dart';
import '../modules/questionnaire/controllers/questionnaire_controller.dart';
import '../modules/questionnaire/views/questionnaire_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.login,
      page: LoginScreen.new,
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => Get.find<AuthController>());
      }),
    ),
    GetPage<dynamic>(
      name: AppRoutes.register,
      page: RegisterScreen.new,
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => Get.find<AuthController>());
      }),
    ),
    GetPage<dynamic>(
      name: AppRoutes.home,
      page: HomeScreen.new,
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(
          () => HomeController(
            getQuestionnaires: Get.find<GetQuestionnairesUseCase>(),
            getUserSubmissions: Get.find<GetUserSubmissionsUseCase>(),
          ),
        );
      }),
    ),
    GetPage<dynamic>(
      name: AppRoutes.questionnaire,
      page: QuestionnaireScreen.new,
      binding: BindingsBuilder(() {
        Get.lazyPut<QuestionnaireController>(
          () => QuestionnaireController(
            authController: Get.find(),
            saveQuestionnaireSubmission:
                Get.find<SaveQuestionnaireSubmissionUseCase>(),
            locationService: Get.find(),
            questionnaire: Get.arguments as Questionnaire,
          ),
        );
      }),
    ),
    GetPage<dynamic>(
      name: AppRoutes.profile,
      page: ProfileScreen.new,
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(
          () => ProfileController(
            authController: Get.find(),
            getUserSubmissions: Get.find<GetUserSubmissionsUseCase>(),
          ),
        );
      }),
    ),
  ];
}
