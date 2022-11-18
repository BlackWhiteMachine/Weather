import 'package:weather/features/cities_list/domain/cities_list_repository.dart';

class CitiesListRepositoryImpl implements CitiesListRepository {

  @override
  Future<List<String>> getCities() async {
    await Future.delayed(const Duration(seconds: 2));
    return _citiesList;
  }

  static const _citiesList = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
    'Philadelphia',
    'San Antonio',
    'San Diego',
    'Dallas',
    'San Jose',
    'Austin',
    'Jacksonville',
    'Fort Worth',
    'Columbus',
    'Indianapolis',
    'Charlotte',
    'San Francisco',
    'Seattle',
    'Denver',
    'Washington',
    'Nashville-Davidson',
    'Oklahoma City',
    'El Paso',
    'Boston',
    'Portland',
    'Las Vegas',
    'Detroit',
    'Memphis',
    'Louisville-Jefferson County',
    'Baltimore',
    'Milwaukee',
    'Albuquerque',
    'Tucson',
    'Fresno',
    'Sacramento',
    'Kansas City',
    'Mesa',
    'Atlanta',
    'Omaha',
    'Colorado Springs',
    'Raleigh',
    'Long Beach',
    'Virginia Beach',
    'Miami',
    'Oakland',
    'Minneapolis',
    'Tulsa',
    'Bakersfield',
    'Wichita',
    'Arlington'
  ];
}