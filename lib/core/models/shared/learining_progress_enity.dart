class LearningProgressEntity {
  final DateTime date;
  final int lessonsCompleted;
  final int cardsReviewed;

  const LearningProgressEntity({
    required this.date,
    required this.lessonsCompleted,
    required this.cardsReviewed,
  });
}