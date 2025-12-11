class DeckModel {
  final int userId;
  final String id;
  final String title;
  final String description;

  const DeckModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.description,
  });

  DeckModel copyWith({
    String? title,
    String? description,
  }) {
    return DeckModel(
      userId: userId,
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}