import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsecutiveDaysTracker extends StatefulWidget {
  @override
  _ConsecutiveDaysTrackerState createState() => _ConsecutiveDaysTrackerState();
}

class _ConsecutiveDaysTrackerState extends State<ConsecutiveDaysTracker> {
  int consecutiveDays = 1;

  @override
  void initState() {
    super.initState();
    _loadConsecutiveDays();
  }

  Future<void> _loadConsecutiveDays() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? lastAccessDateString = prefs.getString('lastAccessDate');
  if (lastAccessDateString != null && lastAccessDateString.isNotEmpty) {
    DateTime lastAccessDate = DateTime.parse(lastAccessDateString);
    DateTime currentDate = DateTime.now();
    if (lastAccessDate.difference(currentDate).inDays.abs() == 1) {
      // If last access date is yesterday, update consecutive days count
      setState(() {
        consecutiveDays++;
      });
    } else if (lastAccessDate.difference(currentDate).inDays.abs() > 1) {
      // If last access date is not yesterday or today, reset consecutive days count
      setState(() {
        consecutiveDays = 1;
      });
    }
  }
  // Store current date as last access date
  await prefs.setString('lastAccessDate', DateTime.now().toString());
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(100, 15, 100, 15), // Add padding
      decoration: BoxDecoration(
        color: AppLightBlue, // Change color as desired
        borderRadius: BorderRadius.circular(5), // Add rounded corners
        
      ),
      child: Text(
        'Consecutive Days: $consecutiveDays',
        style: const TextStyle(color: Colors.black), // Change text color as desired
      ),
    );
  }
}
