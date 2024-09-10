import 'package:flutter/material.dart';
import '../models/current_weather_model.dart';

class CurrentWeather extends StatelessWidget {
  final CurrentWeatherModel weather;

  const CurrentWeather({required this.weather});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  '${weather.temperature}°C',
                  style: const TextStyle(
                      fontSize: 56, fontWeight: FontWeight.bold),
                ),
                Text(
                  weather.description,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              width: 120,
              height: 120,
              child: Image.network(
                'http:${weather.icon}',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Row(children: [
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(Icons.thermostat_outlined),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Sensación: ${weather.feelsLike}°C',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(Icons.air),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Viento: ${weather.windSpeed} km/h',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ]),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                Row(children: [
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(Icons.cloud_outlined),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Nubes: ${weather.cloudiness}%',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(Icons.water_drop_outlined),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Humedad: ${weather.humidity}%',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
