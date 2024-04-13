import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        title: const Text('Application Theme'),
        backgroundColor: LightModeBackgroundColor,
      ),
      body: const Center(
        child: Text('Theme Screen Body'),
      ),
    );
  }
}
