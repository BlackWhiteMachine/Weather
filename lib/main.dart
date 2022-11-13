import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/detail_weather_information/data/weather_repository.dart';
import 'package:weather/weather_app.dart';
import 'package:weather/weather_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = WeatherBlocObserver();
  runApp(WeatherApp(weatherRepository: WeatherRepository()));
}
