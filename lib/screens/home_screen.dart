import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/weather_app_bar.dart';
import '../main.dart'; // Importa el archivo principal para acceder al estado del tema

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  WeatherModel? _weather;
  final WeatherService _weatherService = WeatherService();

  void _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeather(_cityController.text);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al obtener el clima')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: WeatherAppBar(
      //   cityName: _weather?.cityName ?? "",
      //   isDarkMode: WeatherApp.of(context)?.isDark ?? false,
      //   onDarkModeChanged: (isDarkMode) {
      //     WeatherApp.of(context)?.toggleTheme();
      //   },
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Ingrese el nombre de la ciudad',
                // suffixIcon: IconButton(
                //   icon: const Icon(Icons.search),
                //   onPressed: _fetchWeather,
                // ),
              ),
            ),
            const SizedBox(height: 20),
            if (_weather != null) ...[
              Text(
                _weather!.cityName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '${_weather!.temperature}°C',
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              Text(
                _weather!.description,
                style: const TextStyle(fontSize: 18),
              ),
              Image.network('http:${_weather!.icon}'),
            ] else if (_cityController.text.isNotEmpty) ...[
              const Text(
                'Ingrese una ciudad para ver el clima',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
