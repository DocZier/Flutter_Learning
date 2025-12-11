import 'package:test_practic/core/models/lessons/test_entity.dart';
import 'package:test_practic/data/repositories/lessons/test_repository.dart';

class GetQuestionsForLessonUseCase {
  final TestsRepository repository;

  GetQuestionsForLessonUseCase(this.repository);

  Future<List<TestEntity>> execute(int lessonId, {required int userId}) async {
    return await repository.getQuestionsForLesson(lessonId, userId: userId);
  }
}
