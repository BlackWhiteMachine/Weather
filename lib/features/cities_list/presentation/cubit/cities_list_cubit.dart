import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/cities_list/data/cities_list_repository.dart';

part 'cities_list_state.dart';

class CitiesListCubit extends Cubit<CitiesListState> {
  CitiesListCubit(this._citiesListRepository) : super(CitiesListState());

  final CitiesListRepository _citiesListRepository;

  Future<void> init() async {
    log('CitiesListCubit: init');

    final citiesList = await _citiesListRepository.getCities();

    log('CitiesListCubit: init: citiesList: $citiesList');

    emit(
      state.copyWith(
        status: CitiesListStatus.success,
        citiesList: citiesList,
      ),
    );
  }

}