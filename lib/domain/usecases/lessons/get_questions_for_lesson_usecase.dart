import 'package:test_practic/core/models/lessons/test_model.dart';
import 'package:test_practic/data/repositories/lessons/test_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/lessons/test_repository.dart';

class GetQuestionsForLessonUseCase {
  final TestsRepository repository;

  GetQuestionsForLessonUseCase(this.repository);

  Future<List<TestModel>> execute(int lessonId, {required int userId}) async {
    return await repository.getQuestionsForLesson(lessonId, userId: userId);
  }
}
