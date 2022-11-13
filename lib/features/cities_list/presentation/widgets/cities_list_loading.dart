import 'package:flutter/material.dart';

class CitiesListLoading extends StatelessWidget {
  const CitiesListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        CircularProgressIndicator()
      ],
    );
  }
}