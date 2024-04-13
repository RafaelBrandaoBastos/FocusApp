import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: LightModeBackgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/logo.png'),
                width: 100,
              ),
            ]
          ),
          const SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            _SquareButton(
              onPressed: () {
                
              },
              label: 'New Account',
            ),
            const SizedBox(width: 20), // Add some space between buttons
            _SquareButton(
              onPressed: () {
                
              },
              label: 'Existing Account',
            ),
          ])
        ],
      ),
    );
  }
}

class _SquareButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const _SquareButton({
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: 150, // Adjust the width as needed
          height: 40, // Adjust the height as needed
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppLightBlue),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
