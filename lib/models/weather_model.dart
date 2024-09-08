// lib/models/weather_model.dart

class WeatherModel {
  final String city;
  final String country;
  final double temperature;
  final String description;
  final String icon;

  WeatherModel({
    required this.city,
    required this.country,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['location']['name'],
      country: json['location']['country'],
      temperature: json['current']['temp_c'].toDouble(),
      description: json['current']['condition']['text'],
      icon: json['current']['condition']['icon'],
    );
  }
}
