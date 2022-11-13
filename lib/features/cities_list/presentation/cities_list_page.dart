import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/cities_list/data/cities_list_repository.dart';
import 'package:weather/features/cities_list/presentation/cubit/cities_list_cubit.dart';
import 'package:weather/features/cities_list/presentation/widgets/widgets.dart';
import 'package:weather/features/detail_weather_information/presentation/cubit/weather_cubit.dart';
import 'package:weather/features/detail_weather_information/presentation/weather_page.dart';

class CitiesListPage extends StatelessWidget {
  const CitiesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    //  create: (context) => CitiesListCubit(context.read<CitiesListRepository>()),
      create: (context) {
        final cubit = CitiesListCubit(CitiesListRepository());
        cubit.init();
        return cubit;
      },
      child: const CitiesListView(),
    );
  }
}

class CitiesListView extends StatefulWidget {
  const CitiesListView({super.key});

  @override
  State<CitiesListView> createState() => _CitiesListViewState();
}

class _CitiesListViewState extends State<CitiesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose city'),
      ),
      body: Center(
        child: BlocConsumer<CitiesListCubit, CitiesListState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.status) {
              case CitiesListStatus.initial:
                return const CitiesListEmpty();
              case CitiesListStatus.loading:
                return const CitiesListLoading();
              case CitiesListStatus.success:
                return CitiesListSuccessful(
                  citiesList: state.citiesList,
                  onItemClicked: (String city) {
                    Navigator.of(context).push<void>(
                      WeatherPage.route(city),
                    );
                    },
                );
              case CitiesListStatus.failure:
                return const CitiesListError();
            }
          },
        ),
      ),
    );
  }
}