import 'package:flutter/material.dart';
import '../models/hourly_weather_model.dart';

class HourlyForecast extends StatelessWidget {
  final List<HourlyWeatherModel> hourlyWeather;

  const HourlyForecast({required this.hourlyWeather});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: hourlyWeather.map((hour) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  hour.time.split(' ')[1], // Solo muestra la hora
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
                Image.network('http:${hour.icon}', width: 50, height: 50),
                Text(
                  '${hour.temperature}°',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
