class DeckLocalDto {
  final int userId;
  final String id;
  final String title;
  final String description;

  DeckLocalDto({
    required this.userId,
    required this.id,
    required this.title,
    required this.description,
  });

  factory DeckLocalDto.fromJson(Map<String, dynamic> json) {
    return DeckLocalDto(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'description': description,
    };
  }
}