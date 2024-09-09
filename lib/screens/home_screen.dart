import 'package:flutter/material.dart';
import '../main.dart';

import '../models/current_weather_model.dart';
import '../models/hourly_weather_model.dart';
import '../models/daily_weather_model.dart';
import '../services/weather_api_service.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/hourly_forecast_widget.dart';
import '../widgets/daily_forecast_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CurrentWeatherModel? _currentWeather;
  List<HourlyWeatherModel>? _hourlyForecast;
  List<DailyWeatherModel>? _dailyForecast;
  final WeatherService _weatherService = WeatherService();
  bool _isLoading = false;

  void _fetchWeather(String city) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final currentWeather = await _weatherService.getCurrentWeather(city);
      final hourlyForecast = await _weatherService.getHourlyForecast(city);
      final dailyForecast = await _weatherService.getDailyForecast(city);
      setState(() {
        _currentWeather = currentWeather;
        _hourlyForecast = hourlyForecast;
        _dailyForecast = dailyForecast;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al obtener el clima')),
      );
    }
  }

  void updateCity(String newCity) {
    setState(() {
      _currentWeather = null;
      _hourlyForecast = null;
      _dailyForecast = null;
    });
    _fetchWeather(newCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WeatherAppBar(
        city: _currentWeather?.city ?? '',
        country: _currentWeather?.country ?? '',
        isDarkMode: WeatherApp.of(context)?.isDark ?? false,
        onDarkModeChanged: (isDarkMode) {
          WeatherApp.of(context)?.toggleTheme();
        },
        onCitySelected: updateCity,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (_currentWeather != null &&
                  _hourlyForecast != null &&
                  _dailyForecast != null) ...[
                CurrentWeather(weather: _currentWeather!),
                HourlyForecast(hourlyWeather: _hourlyForecast!),
                DailyForecast(dailyWeather: _dailyForecast!),
              ],
              if (!_isLoading &&
                  _currentWeather == null &&
                  _hourlyForecast == null &&
                  _dailyForecast == null)
                const Center(
                  child: Text(
                    'Ingrese una ciudad para ver el clima',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
