//Flutter
import 'package:flutter/material.dart';
//Navbar Screens
import 'package:flux_focus_and_productivity/home/home_screen.dart';
import 'package:flux_focus_and_productivity/settings/main_settings_screen.dart';
import 'package:flux_focus_and_productivity/tasks/tasks_screen.dart';
import 'package:flux_focus_and_productivity/timer/timer_screen.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({super.key, 
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 8,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          label: 'Timer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: AppDefaultBlue,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HomeScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child; // Return the child directly without applying any transition
              },
            ),
          );
        }
        if (index == 1) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const TasksScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child; // Return the child directly without applying any transition
              },
            ),
          );
        }
        if (index == 2) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const TimerScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child; // Return the child directly without applying any transition
              },
            ),
          );
        }
        // If the settings icon is tapped (index 3), navigate to the settings screen
        if (index == 3) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const MainSettingsScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child; // Return the child directly without applying any transition
              },
            ),
          );
        } else {
          // Otherwise, call the provided onItemTapped callback
          onItemTapped(index);
        }
      },
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}
