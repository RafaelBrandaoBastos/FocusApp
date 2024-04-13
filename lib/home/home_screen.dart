import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';
import 'package:flux_focus_and_productivity/navbar-and-menus/bottom_navigation_bar.dart';
import 'package:flux_focus_and_productivity/home/heatmap_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,// Set the background color here
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Flux: Focus and Productivity'),
        centerTitle: true,
        backgroundColor: LightModeBackgroundColor,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeatMapCalendar(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0, // Adjust selectedIndex as needed for each screen
        onItemTapped: (index) {
          // Handle bottom navigation taps if needed
        },
      ),
    );
  }
}
