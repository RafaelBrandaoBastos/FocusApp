import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/navbar-and-menus/bottom_navigation_bar.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';
import 'package:flux_focus_and_productivity/timer/clock.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Timer')),
        backgroundColor: LightModeBackgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ClockView(),
                  const SizedBox(height: 100), // Add some space between ClockView and buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SquareButton(
                        onPressed: () {
                          // Handle timer button pressed
                        },
                        label: 'Timer',
                      ),
                      const SizedBox(width: 20), // Add some space between buttons
                      _SquareButton(
                        onPressed: () {
                          // Handle stopwatch button pressed
                        },
                        label: 'Stopwatch',
                      ),
                      const SizedBox(width: 20), // Add some space between buttons
                      _SquareButton(
                        onPressed: () {
                          // Handle alarm button pressed
                        },
                        label: 'Alarm',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 2, // Adjust selectedIndex as needed for each screen
        onItemTapped: (index) {
          // Handle bottom navigation taps if needed
        },
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
          width: 100, // Adjust the width as needed
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
