class LearningProgressModel {
  final DateTime date;
  final int lessonsCompleted;
  final int cardsReviewed;

  const LearningProgressModel({
    required this.date,
    required this.lessonsCompleted,
    required this.cardsReviewed,
  });
}