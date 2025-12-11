import 'package:test_practic/data/repositories/lessons/test_repository.dart';

class ClearUserTestProgressUseCase {
  final TestsRepository repository;

  ClearUserTestProgressUseCase(this.repository);

  void execute(int userId) {
    repository.clearUserProgress(userId);
  }
}