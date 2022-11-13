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
              city,
              style: theme.textTheme.titleMedium,
            ),
        );
      },
      padding: const EdgeInsets.all(32),
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemCount: citiesList.length,
    );

  }

}