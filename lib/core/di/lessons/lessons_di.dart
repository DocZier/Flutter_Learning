import 'package:get_it/get_it.dart';
import 'package:test_practic/domain/usecases/lessons/add_test_stats_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/add_to_review_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/clear_user_progress_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/clear_user_test_progress_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/get_due_questions_for_review_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/get_lesson_by_id_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/get_lesson_completed_date_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/get_lesson_page_index_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/get_lessons_for_review_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/get_lessons_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/get_questions_for_lesson_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/get_user_test_stats_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/is_lesson_complete_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/mark_lesson_complete.dart';
import 'package:test_practic/domain/usecases/lessons/save_lesson_page_index_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/update_review_interval_usecase.dart';

import '../../../data/repositories/lessons/lessons_repository.dart';
import '../../../data/repositories/lessons/test_repository.dart';
import '../../../data/datasources/local/lessons/lessons_local_source.dart';
import '../../../data/datasources/local/lessons/test_local_source.dart';
import '../../../data/datasources/remote/lessons/lessons_remote_source.dart';
import '../../../data/datasources/remote/lessons/test_remote_source.dart';

void registerLessonsDependencies() {
  GetIt.I.registerLazySingleton<LessonsLocalDataSource>(
        () => LessonsLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<LessonsRemoteDataSource>(
        () => LessonsRemoteDataSource(),
  );
  GetIt.I.registerLazySingleton<TestsLocalDataSource>(
        () => TestsLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<TestsRemoteDataSource>(
        () => TestsRemoteDataSource(),
  );

  GetIt.I.registerLazySingleton<TestsRepository>(
        () => TestsRepositoryImpl(
      localDataSource: GetIt.I(),
      remoteDataSource:  GetIt.I(),
    ),
  );

  GetIt.I.registerLazySingleton<LessonsRepository>(
        () => LessonsRepositoryImpl(
      localDataSource:  GetIt.I(),
      remoteDataSource: GetIt.I(),
    ),
  );

  GetIt.I.registerFactory<GetLessonsUseCase>(() => GetLessonsUseCase(GetIt.I<LessonsRepository>()));
  GetIt.I.registerFactory<GetLessonByIdUseCase>(() => GetLessonByIdUseCase(GetIt.I<LessonsRepository>()));
  GetIt.I.registerFactory<GetLessonPageIndexUseCase>(() => GetLessonPageIndexUseCase(GetIt.I<LessonsRepository>()));
  GetIt.I.registerFactory<SaveLessonPageIndexUseCase>(() => SaveLessonPageIndexUseCase(GetIt.I<LessonsRepository>()));
  GetIt.I.registerFactory<IsLessonCompletedUseCase>(() => IsLessonCompletedUseCase(GetIt.I<LessonsRepository>()));
  GetIt.I.registerFactory<MarkLessonCompletedUseCase>(() => MarkLessonCompletedUseCase(GetIt.I<LessonsRepository>()));
  GetIt.I.registerFactory<GetLessonCompletedDateUseCase>(() => GetLessonCompletedDateUseCase(GetIt.I<LessonsRepository>()));
  GetIt.I.registerFactory<GetLessonsForReviewUseCase>(() => GetLessonsForReviewUseCase(GetIt.I<LessonsRepository>()));
  GetIt.I.registerFactory<ClearUserLessonProgressUseCase>(() => ClearUserLessonProgressUseCase(GetIt.I<LessonsRepository>()));

  GetIt.I.registerFactory<GetQuestionsForLessonUseCase>(() => GetQuestionsForLessonUseCase(GetIt.I<TestsRepository>()));
  GetIt.I.registerFactory<GetDueQuestionsForReviewUseCase>(() => GetDueQuestionsForReviewUseCase(GetIt.I<TestsRepository>()));
  GetIt.I.registerFactory<AddToReviewUseCase>(() => AddToReviewUseCase(GetIt.I<TestsRepository>()));
  GetIt.I.registerFactory<UpdateReviewIntervalUseCase>(() => UpdateReviewIntervalUseCase(GetIt.I<TestsRepository>()));
  GetIt.I.registerFactory<AddTestStatUseCase>(() => AddTestStatUseCase(GetIt.I<TestsRepository>()));
  GetIt.I.registerFactory<GetUserTestStatsUseCase>(() => GetUserTestStatsUseCase(GetIt.I<TestsRepository>()));
  GetIt.I.registerFactory<ClearUserTestProgressUseCase>(() => ClearUserTestProgressUseCase(GetIt.I<TestsRepository>()));

}