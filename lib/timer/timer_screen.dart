import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/navbar-and-menus/bottom_navigation_bar.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Task {
  final int id;
  final String text;
  int tempo;

  Task({required this.id, required this.text, required this.tempo});
}

class TaskManager {
  static const _tasksKey = 'tasks';

  static Future<List<Task>> getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList(_tasksKey) ?? [];
    return tasks.map((taskString) {
      List<String> parts = taskString.split('|');
      return Task(id: int.parse(parts[0]), text: parts[1], tempo: int.parse(parts[2]));
    }).toList();
  }
}

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  double _currentSliderValue = 0;
  int timeLeft = 0;
  Timer? timer;
  bool isCountingDown = false;
  Task? selectedTask;
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    List<Task> tasks = await TaskManager.getTasks();
    if (tasks.isNotEmpty) {
      setState(() {
        _tasks = tasks;
        selectedTask = tasks[0]; // Seleciona a primeira tarefa como padrão
        _currentSliderValue = selectedTask!.tempo.toDouble();
        timeLeft = selectedTask!.tempo;
      });
    }
  }

  void _startCountDown() {
    print("teste");
    if (timer != null && timer!.isActive) return; // Do nothing if timer is already active

    setState(() {
      isCountingDown = true;
    });

    timer?.cancel(); // Cancel any existing timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {

        setState(() {
          timeLeft--;
          _currentSliderValue = timeLeft.toDouble();

          // Atualiza o tempo da tarefa selecionada
          if (selectedTask != null) {
            selectedTask!.tempo = timeLeft;
            _updateSelectedTaskInPrefs(selectedTask!); // Atualiza a tarefa no SharedPreferences
          }
        });
      } else {
        timer.cancel();
        setState(() {
          isCountingDown = false;
        });
      }
    });
  }

// Método para atualizar a tarefa selecionada no SharedPreferences
  void _updateSelectedTaskInPrefs(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList(TaskManager._tasksKey) ?? [];
    int index = tasks.indexWhere((taskString) => taskString.startsWith('${task.id}|'));
    if (index != -1) {
      tasks[index] = '${task.id}|${task.text}|${task.tempo}';
      await prefs.setStringList(TaskManager._tasksKey, tasks);
    }
  }

  void _stopCountDown() {
    timer?.cancel(); // Cancel the timer
    setState(() {
      isCountingDown = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Timer")),
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
                  DropdownButton<Task>(
                    value: selectedTask,
                    items: _tasks.map((Task task) {
                      return DropdownMenuItem<Task>(
                        value: task,
                        child: Text(task.text),
                      );
                    }).toList(),
                    onChanged: (Task? task) {
                      setState(() {
                        selectedTask = task!;
                        _currentSliderValue = selectedTask!.tempo.toDouble();
                        timeLeft = selectedTask!.tempo;
                      });
                      _stopCountDown(); // Stop the countdown when task changes
                    },
                  ),
                  Slider(
                    value: _currentSliderValue,
                    max: 24,
                    divisions: 24,
                    label: _currentSliderValue.round().toString(),
                    onChanged: isCountingDown ? null : (double value) {
                      setState(() {
                        _currentSliderValue = value;
                        timeLeft = _currentSliderValue.toInt(); // Converte para int
                        selectedTask!.tempo = _currentSliderValue.toInt(); // Converte para int
                        _updateSelectedTaskInPrefs(selectedTask!); // Atualiza a tarefa no SharedPreferences
                      });
                    },
                  ),
                  Text('$timeLeft', style: TextStyle(fontSize: 70)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SquareButton(
                        onPressed: _startCountDown,
                        label: 'Start Activity',
                      ),
                      const SizedBox(width: 20),
                      _SquareButton(
                        onPressed: _stopCountDown,
                        label: 'Stop Activity',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 2,
        onItemTapped: (index) {},
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
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
