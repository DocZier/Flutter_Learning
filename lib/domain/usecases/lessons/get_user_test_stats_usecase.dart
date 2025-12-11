import 'package:test_practic/data/repositories/lessons/test_repository.dart';

class GetUserTestStatsUseCase {
  final TestsRepository repository;

  GetUserTestStatsUseCase(this.repository);

  Map<String, dynamic> execute(int userId) {
    return repository.getStatsForUser(userId);
  }
}
