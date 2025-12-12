import 'package:test_practic/data/repositories/lessons/test_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/lessons/test_repository.dart';

class AddTestStatUseCase {
  final TestsRepository repository;

  AddTestStatUseCase(this.repository);

  void execute(int userId, int lessonId, {required bool correct}) {
    repository.addStat(userId, lessonId, correct: correct);
  }
}