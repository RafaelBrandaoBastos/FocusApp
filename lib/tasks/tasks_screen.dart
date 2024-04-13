import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/navbar-and-menus/bottom_navigation_bar.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Tasks')),
        backgroundColor: LightModeBackgroundColor,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 20.0, // Adjust the distance from the bottom as needed
            right: 20.0, // Adjust the distance from the right as needed
            child: FloatingActionButton(
              onPressed: () {
                // Add tasks button pressed
              },
              backgroundColor: const Color.fromARGB(175, 0, 0, 255),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 1, // Adjust selectedIndex as needed for each screen
        onItemTapped: (index) {
          // Handle bottom navigation taps if needed
        },
      ),
    );
  }
}
