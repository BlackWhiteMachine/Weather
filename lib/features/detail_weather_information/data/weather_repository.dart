import 'dart:async';

import 'package:weather/core/data/open_meteo_api_client.dart';
import 'package:weather/features/detail_weather_information/data/database_helper.dart';
import 'package:weather/features/detail_weather_information/domain/model/weather.dart';

class WeatherRepository {
  WeatherRepository({OpenMeteoApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? OpenMeteoApiClient(),
        _databaseHelper = DatabaseHelper.instance;

  final OpenMeteoApiClient _weatherApiClient;
  final DatabaseHelper _databaseHelper;

  Stream<Weather> getWeather(String cityName) async* {
    final cachedWeather = await _getWeatherFromDatabase(cityName);
    if (cachedWeather != null) {
      yield cachedWeather;
    }

    try {
      final weather = await _getWeatherFromRemote(cityName);

      yield weather;

      _databaseHelper.insert(cityName, weather);
    } catch (error) {
      if (cachedWeather == null) {
        throw error;
      }
    }
  }

  Future<Weather> _getWeatherFromRemote(String cityName) async {
    final location = await _weatherApiClient.locationSearch(cityName);
    final weatherResponse = await _weatherApiClient.getWeather(
      latitude: location.latitude,
      longitude: location.longitude,
    );

    return Weather(
      temperature: weatherResponse.temperature,
      location: location.name,
      condition: weatherResponse.weatherCode.toInt().toCondition,
    );
  }

  Future<Weather?> _getWeatherFromDatabase(String cityName) async {
    final cachedWeather = await _databaseHelper.select(cityName);
    return cachedWeather;
  }
}

extension on int {
  WeatherCondition get toCondition {
    switch (this) {
      case 0:
        return WeatherCondition.clear;
      case 1:
      case 2:
      case 3:
      case 45:
      case 48:
        return WeatherCondition.cloudy;
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
      case 95:
      case 96:
      case 99:
        return WeatherCondition.rainy;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherCondition.snowy;
      default:
        return WeatherCondition.unknown;
    }
  }
}