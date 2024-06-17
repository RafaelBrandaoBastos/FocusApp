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
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'The Flux app is developed and maintained by a student duo from the Pontifical Catholic University of Minas Gerais, Brazil. '
                'For any bug reports, suggestions, or other reasons why one might '
                'want to contact us, you may do so through either our mail at '
                'fluxappdev@gmail.com or through our profile on X (formerly Twitter) '
                'at @fluxfp',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

