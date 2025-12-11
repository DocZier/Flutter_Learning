class DeckEntity {
  final int userId;
  final String id;
  final String title;
  final String description;

  const DeckEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.description,
  });

  DeckEntity copyWith({
    String? title,
    String? description,
  }) {
    return DeckEntity(
      userId: userId,
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}