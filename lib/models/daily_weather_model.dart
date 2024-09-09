// lib/models/daily_weather_model.dart

class DailyWeatherModel {
  final String day;
  final double high;
  final double low;
  final String icon;

  DailyWeatherModel({
    required this.day,
    required this.high,
    required this.low,
    required this.icon,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherModel(
      day: json['date'],
      high: json['day']['maxtemp_c'].toDouble(),
      low: json['day']['mintemp_c'].toDouble(),
      icon: json['day']['condition']['icon'],
    );
  }
}
