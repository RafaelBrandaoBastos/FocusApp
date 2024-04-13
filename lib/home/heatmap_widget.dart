import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HeatMapCalendar extends StatelessWidget {
  const HeatMapCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      datasets: {
        DateTime(2024, 3, 6): 1,
        DateTime(2024, 3, 7): 3,
        DateTime(2024, 3, 8): 6,
        DateTime(2024, 3, 9): 3,
        DateTime(2024, 3, 13): 3,
      },
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now(),
      showColorTip: false,
      size: 42,
      colorMode: ColorMode.opacity,
      scrollable: false,
      colorsets: const {
        1: Color.fromARGB(15, 0, 0, 150),
        3: Color.fromARGB(30, 0, 0, 150),
        6: Color.fromARGB(35, 0, 0, 150),
      },
      onClick: (value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
      },
    );
  }
}
