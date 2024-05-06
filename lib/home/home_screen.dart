import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';
import 'package:flux_focus_and_productivity/navbar-and-menus/bottom_navigation_bar.dart';
import 'package:flux_focus_and_productivity/home/heatmap_widget.dart';
import 'package:flux_focus_and_productivity/home/consecutive_days_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Flux: Focus and Productivity'),
        centerTitle: true,
        backgroundColor: LightModeBackgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConsecutiveDaysTracker(),
            const SizedBox(height: 100), 
            const HeatMapCalendar(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0,
        onItemTapped: (index) {
        },
      ),
    );
  }
}