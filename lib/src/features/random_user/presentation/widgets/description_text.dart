import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  final String? description;

  const DescriptionText({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description!,
      style: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
