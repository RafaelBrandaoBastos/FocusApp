import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HeatMapCalendar extends StatefulWidget {
  const HeatMapCalendar({super.key});

  @override
  _HeatMapCalendarState createState() => _HeatMapCalendarState();
}

class _HeatMapCalendarState extends State<HeatMapCalendar> {
  late Database _database;
  Map<DateTime, int> _datasets = {};

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
    _fetchData();
  }

  Future<void> _initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'app_usage.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE app_usage(date TEXT PRIMARY KEY, intensity INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> _fetchData() async {
    final DateTime startDate = DateTime.now().subtract(const Duration(days: 365));
    final DateTime endDate = DateTime.now().add(const Duration(days: 365));

    for (DateTime date = startDate; date.isBefore(endDate); date = date.add(const Duration(days: 1))) {
      // Retrieve app usage data for the current date
      // For demonstration purposes, let's assume you have a method to get the time spent on the app for a specific date
      Duration timeSpent = getTimeSpent(date);

      // Calculate intensity based on the time spent
      int intensity = calculateIntensity(timeSpent);

      // Add the calculated intensity to the dataset
      _datasets[date] = intensity;
    }

    setState(() {
      _datasets = _datasets;
    });
  }

  Duration getTimeSpent(DateTime date) {
    // Dummy method to simulate getting time spent on the app for a specific date
    // Replace this with your actual implementation
    // For demonstration purposes, let's assume we return a random duration
    return Duration(minutes: DateTime.now().millisecondsSinceEpoch % 180);
  }

  int calculateIntensity(Duration timeSpent) {
    if (timeSpent.inMinutes <= 30) {
      return 1; // 30 minutes or less
    } else if (timeSpent.inMinutes <= 60) {
      return 3; // 1 hour or less
    } else {
      return 6; // over 2 hours
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime startDate = DateTime.now().subtract(const Duration(days: 365));
    final DateTime endDate = DateTime.now().add(const Duration(days: 365));

    return HeatMap(
      datasets: _datasets,
      startDate: startDate,
      endDate: endDate,
      showText: true,
      showColorTip: false,
      size: 40,
      colorMode: ColorMode.opacity,
      scrollable: true,
      colorsets: const {
        1: Color.fromARGB(15, 0, 0, 150),
        3: Color.fromARGB(25, 0, 0, 150),
        6: Color.fromARGB(30, 0, 0, 150),
      },
    );
  }
}
