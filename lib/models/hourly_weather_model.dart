// lib/models/hourly_weather_model.dart

class HourlyWeatherModel {
  final String time;
  final double temperature;
  final String icon;

  HourlyWeatherModel({
    required this.time,
    required this.temperature,
    required this.icon,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      time: json['time'],
      temperature: json['temp_c'].toDouble(),
      icon: json['condition']['icon'],
    );
  }
}
