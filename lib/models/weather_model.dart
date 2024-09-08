// lib/models/weather_model.dart

class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['location']['name'],
      temperature: json['current']['temp_c'].toDouble(),
      description: json['current']['condition']['text'],
      icon: json['current']['condition']['icon'],
    );
  }
}
