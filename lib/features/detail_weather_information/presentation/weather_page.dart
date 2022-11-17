import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/detail_weather_information/domain/weather_repository.dart';
import 'package:weather/features/detail_weather_information/presentation/cubit/weather_cubit.dart';
import 'package:weather/features/detail_weather_information/presentation/model/weather_state.dart';
import 'package:weather/features/detail_weather_information/presentation/theme_cubit.dart';
import 'package:weather/features/detail_weather_information/presentation/widgets/widgets.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  static Route<void> route(String city) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) {
          final cubit = WeatherCubit(context.read<WeatherRepository>());
          cubit.fetchWeather(city);
          return cubit;
        },
        child: const WeatherView(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather'),
      ),
      body: Center(
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<ThemeCubit>().updateTheme(state.weather);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return const WeatherEmpty();
              case WeatherStatus.loading:
                return const WeatherLoading();
              case WeatherStatus.success:
                return WeatherSuccessful(
                  weather: state.weather,
                  onRefresh: () {
                    return context.read<WeatherCubit>().refreshWeather();
                  },
                );
              case WeatherStatus.failure:
                return const WeatherError();
            }
          },
        ),
      ),
    );
  }
}