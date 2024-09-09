import 'package:flutter/material.dart';
import '../models/daily_weather_model.dart';

class DailyForecast extends StatelessWidget {
  final List<DailyWeatherModel> dailyWeather;

  const DailyForecast({required this.dailyWeather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: dailyWeather.map((day) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(day.day),
            Text('${day.high}° / ${day.low}°'),
            Image.network('http:${day.icon}'),
          ],
        );
      }).toList(),
    );
  }
}
