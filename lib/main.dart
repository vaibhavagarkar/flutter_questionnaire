import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.dart';
import 'app/data/datasources/mock_questionnaire_data_source.dart';
import 'app/data/local/app_database_service.dart';
import 'app/data/local/session_service.dart';
import 'app/data/repositories/auth_repository.dart';
import 'app/data/repositories/questionnaire_repository.dart';
import 'app/data/repositories/submission_repository.dart';
import 'app/data/services/location_service.dart';
import 'app/domain/repositories/auth_repository_contract.dart';
import 'app/domain/repositories/questionnaire_repository_contract.dart';
import 'app/domain/repositories/submission_repository_contract.dart';
import 'app/domain/services/location_service_contract.dart';
import 'app/domain/usecases/check_phone_exists_use_case.dart';
import 'app/domain/usecases/clear_user_session_use_case.dart';
import 'app/domain/usecases/get_questionnaires_use_case.dart';
import 'app/domain/usecases/get_user_submissions_use_case.dart';
import 'app/domain/usecases/login_user_use_case.dart';
import 'app/domain/usecases/register_user_use_case.dart';
import 'app/domain/usecases/restore_user_session_use_case.dart';
import 'app/domain/usecases/save_questionnaire_submission_use_case.dart';
import 'app/domain/usecases/save_user_session_use_case.dart';
import 'app/modules/auth/controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final databaseService = AppDatabaseService();
  await databaseService.init();

  final sessionService = SessionService();
  await sessionService.init();

  const mockQuestionnaireDataSource = MockQuestionnaireDataSource();

  // Keep shared dependencies here so feature bindings stay small.
  Get
    ..put<AppDatabaseService>(databaseService, permanent: true)
    ..put<SessionService>(sessionService, permanent: true)
    ..put<MockQuestionnaireDataSource>(
      mockQuestionnaireDataSource,
      permanent: true,
    )
    ..put<LocationServiceContract>(LocationService(), permanent: true)
    ..put<AuthRepositoryContract>(
      AuthRepository(databaseService),
      permanent: true,
    )
    ..put<QuestionnaireRepositoryContract>(
      QuestionnaireRepository(mockQuestionnaireDataSource),
      permanent: true,
    )
    ..put<SubmissionRepositoryContract>(
      SubmissionRepository(databaseService),
      permanent: true,
    )
    ..put<CheckPhoneExistsUseCase>(
      CheckPhoneExistsUseCase(Get.find<AuthRepositoryContract>()),
      permanent: true,
    )
    ..put<RegisterUserUseCase>(
      RegisterUserUseCase(Get.find<AuthRepositoryContract>()),
      permanent: true,
    )
    ..put<LoginUserUseCase>(
      LoginUserUseCase(Get.find<AuthRepositoryContract>()),
      permanent: true,
    )
    ..put<RestoreUserSessionUseCase>(
      RestoreUserSessionUseCase(
        authRepository: Get.find<AuthRepositoryContract>(),
        sessionService: sessionService,
      ),
      permanent: true,
    )
    ..put<SaveUserSessionUseCase>(
      SaveUserSessionUseCase(sessionService),
      permanent: true,
    )
    ..put<ClearUserSessionUseCase>(
      ClearUserSessionUseCase(sessionService),
      permanent: true,
    )
    ..put<GetQuestionnairesUseCase>(
      GetQuestionnairesUseCase(Get.find<QuestionnaireRepositoryContract>()),
      permanent: true,
    )
    ..put<GetUserSubmissionsUseCase>(
      GetUserSubmissionsUseCase(Get.find<SubmissionRepositoryContract>()),
      permanent: true,
    )
    ..put<SaveQuestionnaireSubmissionUseCase>(
      SaveQuestionnaireSubmissionUseCase(
        Get.find<SubmissionRepositoryContract>(),
      ),
      permanent: true,
    )
    ..put<AuthController>(
      AuthController(
        checkPhoneExists: Get.find<CheckPhoneExistsUseCase>(),
        registerUser: Get.find<RegisterUserUseCase>(),
        loginUser: Get.find<LoginUserUseCase>(),
        restoreUserSession: Get.find<RestoreUserSessionUseCase>(),
        saveUserSession: Get.find<SaveUserSessionUseCase>(),
        clearUserSession: Get.find<ClearUserSessionUseCase>(),
      ),
      permanent: true,
    );

  await Get.find<AuthController>().restoreSession();
  await Get.find<LocationServiceContract>().requestPermissionOnAppStart();
  runApp(const QuestionnaireApp());
}
