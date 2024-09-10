class DailyWeatherModel {
  final DateTime day;
  final double high;
  final double low;
  final String icon;
  final int rainProbability;
  final double windSpeed;
  final String condition;

  DailyWeatherModel({
    required this.day,
    required this.high,
    required this.low,
    required this.icon,
    required this.rainProbability,
    required this.windSpeed,
    required this.condition,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherModel(
      day: DateTime.parse(json['date']),
      high: (json['day']['maxtemp_c'] ?? 0.0).toDouble(),
      low: (json['day']['mintemp_c'] ?? 0.0).toDouble(),
      icon: json['day']['condition']['icon'] ?? '',
      rainProbability: json['day']['daily_chance_of_rain'] ?? 0,
      windSpeed: (json['day']['maxwind_kph'] ?? 0.0).toDouble(),
      condition: json['day']['condition']['text'] ?? 'N/A',
    );
  }
}
