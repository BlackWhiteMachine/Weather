import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/detail_weather_information/domain/weather_repository.dart';
import 'package:weather/features/detail_weather_information/presentation/model/weather_state.dart';
import 'package:weather/features/detail_weather_information/presentation/model/weather_view_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherState());

  final WeatherRepository _weatherRepository;

  Future<void> fetchWeather(String? cityName) async {
    if (cityName == null || cityName.isEmpty) return;

    _obtainWeather(cityName);
  }

  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return;
    if (state.weather == WeatherViewState.empty) return;

    _obtainWeather(state.weather.location);
  }

  Future<void> _obtainWeather(String cityName) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    _weatherRepository.getWeather(cityName)
        .handleError((onError) {
          log('WeatherCubit: onError: $onError');
          emit(state.copyWith(status: WeatherStatus.failure));
        }).listen((weather) {
          final weatherViewState = WeatherViewState.fromRepository(weather);
          emit(
            state.copyWith(
              status: WeatherStatus.success,
              weather: weatherViewState,
            ),
          );
        });
  }
}
