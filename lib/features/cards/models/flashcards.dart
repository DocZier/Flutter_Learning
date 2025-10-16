class Flashcard {
  final String id;
  String question;
  String answer;
  //Интервал измеряется в днях
  int interval;
  DateTime? nextReview;
  double easeFactor;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    required this.interval,
    required this.easeFactor,
  });

  // Алгоритм интервального повторения SM-2
  void updateCard(int quality) {
    if (quality <= 3) {
      interval = 1;
    } else {
      interval = (interval * easeFactor).round();
    }

    easeFactor += (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (easeFactor < 1.3) easeFactor = 1.3;

    nextReview = DateTime.now().add(Duration(days: interval));
  }
}