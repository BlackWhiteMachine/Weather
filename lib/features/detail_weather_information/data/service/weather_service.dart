import 'dart:async';

import 'package:weather/core/data/open_meteo_api_client.dart';
import 'package:weather/features/detail_weather_information/data/model/weather_response.dart';
import 'package:weather/features/detail_weather_information/data/model/location_response.dart';

class LocationNotFoundFailure implements Exception {}

class WeatherNotFoundFailure implements Exception {}

class WeatherService {
  WeatherService({OpenMeteoApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? OpenMeteoApiClient();

  final OpenMeteoApiClient _weatherApiClient;

  Future<LocationResponse> locationSearch(String query) async {
    final locationJson = await _weatherApiClient.geocodingRequest(
        '/v1/search',
        {
          'name': query,
          'count': '1'
        }
    );

    if (!locationJson.containsKey('results')) throw LocationNotFoundFailure();

    final results = locationJson['results'] as List;

    if (results.isEmpty) throw LocationNotFoundFailure();

    return LocationResponse.fromJson(results.first as Map<String, dynamic>);
  }

  Future<WeatherResponse> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final weatherResponse = await _weatherApiClient.weatherRequest(
        'v1/forecast',
        {
          'latitude': '$latitude',
          'longitude': '$longitude',
          'current_weather': 'true'
        }
    );

    if (!weatherResponse.containsKey('current_weather')) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson = weatherResponse['current_weather'] as Map<String, dynamic>;

    return WeatherResponse.fromJson(weatherJson);
  }

}