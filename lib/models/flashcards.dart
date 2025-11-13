class Flashcard {
  final String id;
  final String question;
  final String answer;
  final int interval;
  final DateTime nextReview;
  final double easeFactor;

  const Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    required this.interval,
    required this.easeFactor,
    required this.nextReview,
  });

  Flashcard copyWith({
    String? question,
    String? answer,
    int? interval,
    DateTime? nextReview,
    double? easeFactor,
  }) {
    return Flashcard(
      id: id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      interval: interval ?? this.interval,
      nextReview: nextReview ?? this.nextReview,
      easeFactor: easeFactor ?? this.easeFactor,
    );
  }

  Flashcard applyQuality(int quality) {
    int newInterval = interval;
    double newEF = easeFactor;

    if (quality <= 3) {
      newInterval = 1;
    } else {
      newInterval = (newInterval * newEF).round();
    }

    newEF += (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (newEF < 1.3) newEF = 1.3;

    final newNextReview = DateTime.now().add(Duration(days: newInterval));

    return copyWith(
      interval: newInterval,
      easeFactor: newEF,
      nextReview: newNextReview,
    );
  }
}
