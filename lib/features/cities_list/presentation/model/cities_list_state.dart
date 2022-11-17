import 'package:equatable/equatable.dart';

enum CitiesListStatus { initial, loading, success, failure }

class CitiesListState extends Equatable {
  CitiesListState({
    this.status = CitiesListStatus.initial,
    List<String>? citiesList,
  }) : citiesList = citiesList ?? List.empty();

  final CitiesListStatus status;
  final List<String> citiesList;

  CitiesListState copyWith({
    CitiesListStatus? status,
    List<String>? citiesList,
  }) {
    return CitiesListState(
      status: status ?? this.status,
      citiesList: citiesList ?? this.citiesList,
    );
  }

  @override
  List<Object?> get props => [citiesList];
}