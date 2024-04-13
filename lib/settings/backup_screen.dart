import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        title: const Text('Backup and Export'),
        backgroundColor: LightModeBackgroundColor,
      ),
      body: const Center(
        child: Text('Backup Screen Body'),
      ),
    );
  }
}
