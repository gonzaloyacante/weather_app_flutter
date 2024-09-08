import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/app_bar.dart';
import '../main.dart'; // Importa el archivo principal para acceder al estado del tema

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel? _weather;
  final WeatherService _weatherService = WeatherService();

  // Método para obtener el clima basado en la ciudad ingresada
  void _fetchWeather(String city) async {
    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al obtener el clima')),
      );
    }
  }

  void updateCity(String newCity) {
    setState(() {
      _weather = null;
    });
    _fetchWeather(newCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WeatherAppBar(
        // city: _weather?.city ?? 'Ingrese una ciudad',
        city: _weather?.city ?? '',
        country: _weather?.country ?? '',
        isDarkMode: WeatherApp.of(context)?.isDark ?? false,
        onDarkModeChanged: (isDarkMode) {
          WeatherApp.of(context)?.toggleTheme();
        },
        onCitySelected: updateCity,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if (_weather != null) ...[
              Text(
                '${_weather!.temperature}°C',
                style:
                    const TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
              ),
              Text(
                _weather!.description,
                style: const TextStyle(fontSize: 18),
              ),
              Image.network('http:${_weather!.icon}'),
            ] else ...[
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
          ],
        ),
      ),
    );
  }
}
