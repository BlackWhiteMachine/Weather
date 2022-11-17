import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// Exception thrown when getWeather fails.
class RequestFailure implements Exception {}

class OpenMeteoApiClient {
  OpenMeteoApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrlWeather = 'api.open-meteo.com';
  static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';

  final http.Client _httpClient;

  Future<Map<dynamic, dynamic>> geocodingRequest(
      String path,
      Map<String, dynamic>? queryParameters
      ) async {
    final request = Uri.https(_baseUrlGeocoding, path, queryParameters,);

    final locationResponse = await _httpClient.get(request);

    if (locationResponse.statusCode != 200) {
      throw RequestFailure();
    }

    return jsonDecode(locationResponse.body) as Map;
  }

  Future<Map<String, dynamic>> weatherRequest(
    String path,
    Map<String, dynamic>? queryParameters
  ) async {
    final request = Uri.https(_baseUrlWeather, path, queryParameters);

    final weatherResponse = await _httpClient.get(request);

    if (weatherResponse.statusCode != 200) {
      throw RequestFailure();
    }

    return jsonDecode(weatherResponse.body) as Map<String, dynamic>;
  }
}
