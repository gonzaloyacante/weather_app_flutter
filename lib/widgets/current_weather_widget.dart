// lib/widgets/current_weather.dart

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
                const SizedBox(height: 8), // Espacio entre los textos
                Text(
                  weather.description,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(width: 16), // Espacio entre la columna y la imagen
            Image.network('http:${weather.icon}'),
          ],
        ),
        const SizedBox(height: 16), // Espacio entre las filas
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Row(children: [
                  const Icon(Icons.thermostat_outlined),
                  const SizedBox(width: 4), // Espacio entre el icono y el texto
                  Text(
                    'Sensación: ${weather.feelsLike}°C',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ]),
                const SizedBox(height: 8), // Espacio entre las filas internas
                Row(children: [
                  const Icon(Icons.air),
                  const SizedBox(width: 4), // Espacio entre el icono y el texto
                  Text(
                    'Viento: ${weather.windSpeed} km/h',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ]),
              ],
            ),
            const SizedBox(width: 16), // Espacio entre las columnas
            Column(
              children: [
                Row(children: [
                  const Icon(Icons.cloud_outlined),
                  const SizedBox(width: 4), // Espacio entre el icono y el texto
                  Text(
                    'Nubes: ${weather.cloudiness}%',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ]),
                const SizedBox(height: 8), // Espacio entre las filas internas
                Row(children: [
                  const Icon(Icons.water_drop_outlined),
                  const SizedBox(width: 4), // Espacio entre el icono y el texto
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
