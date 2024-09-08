import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = 'b4f9b019b1804559a04123736241307';
  final String baseUrl = 'http://api.weatherapi.com/v1/current.json';

  Future<WeatherModel> getWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl?key=$apiKey&q=$city'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
