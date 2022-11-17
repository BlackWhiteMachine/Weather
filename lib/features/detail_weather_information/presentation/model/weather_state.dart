import 'package:equatable/equatable.dart';

import 'package:weather/features/detail_weather_information/presentation/model/weather_view_state.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

class WeatherState extends Equatable {
  WeatherState({
    this.status = WeatherStatus.initial,
    WeatherViewState? weather,
  }) : weather = weather ?? WeatherViewState.empty;

  final WeatherStatus status;
  final WeatherViewState weather;

  WeatherState copyWith({
    WeatherStatus? status,
    WeatherViewState? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [status, weather];
}
