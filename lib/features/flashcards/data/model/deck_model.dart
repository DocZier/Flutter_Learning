import '../../domain/entities/deck_entity.dart';

class Deck extends DeckEntity {
  const Deck({
    required super.userId,
    required super.id,
    required super.title,
    required super.description,
  });

  DeckEntity toEntity() => DeckEntity(
    userId: userId,
    id: id,
    title: title,
    description: description,
  );

  factory Deck.fromEntity(DeckEntity entity) => Deck(
    userId: entity.userId,
    id: entity.id,
    title: entity.title,
    description: entity.description,
  );

  @override
  Deck copyWith({
    String? title,
    String? description
  }) {
    return Deck(
      userId: userId,
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}