import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'study_provider.g.dart';

@riverpod
class StudyNotifier extends _$StudyNotifier {
  @override
  bool build() => false;

  void flip() => state = !state;

}