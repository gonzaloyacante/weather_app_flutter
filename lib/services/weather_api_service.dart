import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/current_weather_model.dart';
import '../models/hourly_weather_model.dart';
import '../models/daily_weather_model.dart';

class WeatherService {
  final String apiKey = 'b4f9b019b1804559a04123736241307';
  final String baseUrl = 'http://api.weatherapi.com/v1';

  Future<CurrentWeatherModel> getCurrentWeather(String city) async {
    final response =
        await http.get(Uri.parse('$baseUrl/current.json?key=$apiKey&q=$city'));

    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load current weather');
    }
  }

  Future<List<HourlyWeatherModel>> getHourlyForecast(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$city&hours=24'));

    if (response.statusCode == 200) {
      List<dynamic> hourlyData =
          json.decode(response.body)['forecast']['forecastday'][0]['hour'];
      return hourlyData
          .map((data) => HourlyWeatherModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load hourly forecast');
    }
  }

  Future<List<DailyWeatherModel>> getDailyForecast(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$city&days=7'));

    if (response.statusCode == 200) {
      List<dynamic> dailyData =
          json.decode(response.body)['forecast']['forecastday'];
      return dailyData.map((data) => DailyWeatherModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load daily forecast');
    }
  }
}
