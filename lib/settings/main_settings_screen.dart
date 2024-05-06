import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/navbar-and-menus/bottom_navigation_bar.dart';
import 'package:flux_focus_and_productivity/settings/backup_screen.dart';
import 'package:flux_focus_and_productivity/settings/contact_screen.dart';
import 'package:flux_focus_and_productivity/settings/rate_us_screen.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';
import 'package:flux_focus_and_productivity/settings/account_screen.dart';

class MainSettingsScreen extends StatelessWidget {
  const MainSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Settings')),
        backgroundColor: LightModeBackgroundColor,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: const Center(child: Text('Account')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountScreen()),
                );
              },
            ),
            ListTile(
              title: const Center(child: Text('Backup & Restore')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BackupScreen()),
                );
              },
            ),
            ListTile(
              title: const Center(child: Text('Rate Us')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RateUsScreen()),
                );
              },
            ),
            ListTile(
              title: const Center(child: Text('Contact Info')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactScreen()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 3,
        onItemTapped: (index) {
        },
      ),
    );
  }
}
