import 'flashcards.dart';

class Deck {
  final String id;
  String title;
  String description;
  List<Flashcard> flashcards;

  Deck({
    required this.id,
    required this.title,
    required this.description,
    required this.flashcards
  });

  Deck copyWith({String? name, List<Flashcard>? cards}) {
    return Deck(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      flashcards: flashcards ?? [...this.flashcards],
    );
  }
}