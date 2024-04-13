import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';

class RateUsScreen extends StatelessWidget {
  const RateUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        title: const Text('Rate Us'),
        backgroundColor: LightModeBackgroundColor,
      ),
      body: const Center(
        child: Text('Rating Screen Body'),
      ),
    );
  }
}
