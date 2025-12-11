class SettingsRemoteDto {
  final String id;
  final String userId;
  final String themeMode;
  final int startOfTheDay;

  SettingsRemoteDto({
    required this.id,
    required this.userId,
    required this.themeMode,
    required this.startOfTheDay,
  });

  factory SettingsRemoteDto.fromJson(Map<String, dynamic> json) {
    return SettingsRemoteDto(
      id: json['id'],
      userId: json['userId'],
      themeMode: json['theme'],
      startOfTheDay: json['start_of_the_day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'theme': themeMode,
      'start_of_the_day': startOfTheDay,
    };
  }
}