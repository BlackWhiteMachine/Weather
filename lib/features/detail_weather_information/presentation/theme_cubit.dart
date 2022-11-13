import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/detail_weather_information/domain/model/weather.dart';
import 'package:weather/features/detail_weather_information/presentation/model/weather_view_state.dart';

class ThemeCubit extends Cubit<Color> {
  ThemeCubit() : super(defaultColor);

  static const defaultColor = Color(0xFF2196F3);

  void updateTheme(WeatherViewState? weather) {
    if (weather != null) emit(weather.toColor);
  }
}

extension on WeatherViewState {
  Color get toColor {
    switch (condition) {
      case WeatherCondition.clear:
        return Colors.orangeAccent;
      case WeatherCondition.snowy:
        return Colors.lightBlueAccent;
      case WeatherCondition.cloudy:
        return Colors.blueGrey;
      case WeatherCondition.rainy:
        return Colors.indigoAccent;
      case WeatherCondition.unknown:
        return ThemeCubit.defaultColor;
    }
  }
}