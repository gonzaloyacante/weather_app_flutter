// lib/models/current_weather_model.dart

class CurrentWeatherModel {
  final String city;
  final String country;
  final double temperature;
  final double feelsLike;
  final String description;
  final String icon;
  final double windSpeed;
  final int cloudiness;
  final int humidity;

  CurrentWeatherModel({
    required this.city,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.icon,
    required this.windSpeed,
    required this.cloudiness,
    required this.humidity,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      city: json['location']['name'] ?? '',
      country: json['location']['country'] ?? '',
      temperature: (json['current']['temp_c'] ?? 0.0).toDouble(),
      feelsLike: (json['current']['feelslike_c'] ?? 0.0).toDouble(),
      description: json['current']['condition']['text'] ?? '',
      icon: json['current']['condition']['icon'] ?? '',
      windSpeed: (json['current']['wind_kph'] ?? 0.0).toDouble(),
      cloudiness: json['current']['cloud'] ?? 0,
      humidity: json['current']['humidity'] ?? 0,
    );
  }
}
