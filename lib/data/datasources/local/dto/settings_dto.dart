class SettingsLocalDto {
  final String themeMode;
  final int startOfTheDay;

  SettingsLocalDto({
    required this.themeMode,
    required this.startOfTheDay,
  });

  factory SettingsLocalDto.fromJson(Map<String, dynamic> json) {
    return SettingsLocalDto(
      themeMode: json['theme_mode'] as String? ?? 'system',
      startOfTheDay: json['start_of_the_day'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theme_mode': themeMode,
      'start_of_the_day': startOfTheDay,
    };
  }
}