import 'package:weather/features/detail_weather_information/domain/model/weather.dart';

abstract class WeatherRepository {

  Stream<Weather> getWeather(String cityName);

}