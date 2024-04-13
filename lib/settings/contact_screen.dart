import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        title: const Text('Contact Information'),
        backgroundColor: LightModeBackgroundColor,
      ),
      body: const Center(
        child: Text('Contact Screen Body'),
      ),
    );
  }
}
