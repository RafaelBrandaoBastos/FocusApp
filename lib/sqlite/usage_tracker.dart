import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeTracker {
  static const _lastAccessKey = 'lastAccessDate';
  static const _sessionDurationKey = 'sessionDuration';
  static const _databaseName = 'app_usage.db';
  static const _tableName = 'app_usage';

  static late Database _database;

  // Initialize the database
  static Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_tableName(date TEXT PRIMARY KEY, intensity INTEGER)",
        );
      },
      version: 1,
    );
  }

  // Track the time when the app is opened
  static Future<void> trackAppOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the last access date
    String? lastAccessDateStr = prefs.getString(_lastAccessKey);
    DateTime lastAccessDate = lastAccessDateStr != null ? DateTime.parse(lastAccessDateStr) : DateTime.now();

    // Check if the last access date is not today
    if (!isSameDay(lastAccessDate, DateTime.now())) {
      // Reset session duration if the last access date is not today
      prefs.setInt(_sessionDurationKey, 0);
    }

    // Store the current date as the last access date
    await prefs.setString(_lastAccessKey, DateTime.now().toString());
  }

  //
  static Future<void> trackAppClose() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime lastAccessDate = DateTime.parse(prefs.getString(_lastAccessKey)!);
    int sessionDuration = prefs.getInt(_sessionDurationKey) ?? 0;
    sessionDuration += DateTime.now().difference(lastAccessDate).inSeconds;
    int intensity = _calculateIntensity(sessionDuration);
    await prefs.setInt(_sessionDurationKey, sessionDuration);
    await _updateDatabase(DateTime.now(), intensity);
  }

  //INTENSITY
  static int _calculateIntensity(int sessionDuration) {
    if (sessionDuration <= 1800) {
      return 1;
    } else if (sessionDuration <= 3600) {
      return 3;
    } else {
      return 6;
    }
  }

  static Future<void> _updateDatabase(DateTime date, int intensity) async {
    await _database.insert(
      _tableName,
      {'date': date.toString(), 'intensity': intensity},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}
