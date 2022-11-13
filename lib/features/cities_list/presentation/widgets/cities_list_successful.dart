import 'package:flutter/material.dart';

class CitiesListSuccessful extends StatelessWidget {
  const CitiesListSuccessful({
    super.key,
    required this.citiesList,
    required this.onItemClicked
  });

  final List<String> citiesList;
  final ValueChanged<String> onItemClicked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemBuilder: (context, index) {
        final city = citiesList[index];
        return GestureDetector(
            onTap: () {
              onItemClicked.call(city);
            },
            child: Text(
              'City: $city',
              style: theme.textTheme.headline5,
            ),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: citiesList.length,
    );

  }

}