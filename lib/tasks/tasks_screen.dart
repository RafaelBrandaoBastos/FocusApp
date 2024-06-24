import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flux_focus_and_productivity/navbar-and-menus/bottom_navigation_bar.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';

class Task {
  final int id;
  final String text;
  final int tempo;

  Task({required this.id, required this.text, required this.tempo});
}

class TaskManager {
  static const _tasksKey = 'tasks';

  static Future<void> addTask(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList(_tasksKey) ?? [];
    tasks.add('${task.id}|${task.text}|${task.tempo}');
    await prefs.setStringList(_tasksKey, tasks);
  }

  static Future<List<Task>> getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList(_tasksKey) ?? [];
    return tasks.map((taskString) {
      List<String> parts = taskString.split('|');
      return Task(id: int.parse(parts[0]), text: parts[1], tempo: int.parse(parts[2]));
    }).toList();
  }

  static Future<void> deleteTask(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList(_tasksKey) ?? [];
    tasks.removeWhere((task) => task.startsWith('$id|'));
    await prefs.setStringList(_tasksKey, tasks);
  }

  static Future<void> modifyTask(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList(_tasksKey) ?? [];
    int index = tasks.indexWhere((taskString) => taskString.startsWith('${task.id}|'));
    if (index != -1) {
      tasks[index] = '${task.id}|${task.text}|${task.tempo}';
      await prefs.setStringList(_tasksKey, tasks);
    }
  }
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late List<Task> _tasks;
  int _nextId = 1;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    List<Task> tasks = await TaskManager.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _addTask(String text, int tempo) async {
    Task task = Task(id: _nextId++, text: text, tempo: tempo);
    await TaskManager.addTask(task);
    setState(() {
      _tasks.add(task);
    });
  }

  Future<void> _deleteTask(int index) async {
    await TaskManager.deleteTask(_tasks[index].id);
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _modifyTask(int index) async {
    TextEditingController textController = TextEditingController(text: _tasks[index].text);
    TextEditingController tempoController = TextEditingController(text: _tasks[index].tempo.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modify Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Task',
                ),
              ),
              TextFormField(
                controller: tempoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Tempo',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Task modifiedTask = Task(
                  id: _tasks[index].id,
                  text: textController.text,
                  tempo: int.parse(tempoController.text),
                );
                await TaskManager.modifyTask(modifiedTask);
                setState(() {
                  _tasks[index] = modifiedTask;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteTask(index);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize as needed
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: _tasks != null && _tasks.isNotEmpty
          ? ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: Container(
              decoration: BoxDecoration(
                color: _tasks[index].tempo == 0 ? Colors.green : Colors.blueAccent, // Customize as needed
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(
                  '${_tasks[index].text} - ${_tasks[index].tempo}',
                  style: TextStyle(color: Colors.white), // Customize text color
                ),
                trailing: GestureDetector(
                  onTap: () {
                    _modifyTask(index);
                  },
                  child: const Icon(Icons.edit),
                ),
              ),
            ),
          );
        },
      )
          : Center(
        child: Text('No tasks available'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskModal(context);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 1,
        onItemTapped: (index) {
          // Handle bottom navigation item tap
        },
      ),
    );
  }

  void _showAddTaskModal(BuildContext context) {
    TextEditingController textController = TextEditingController();
    TextEditingController tempoController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Task',
                ),
              ),
              TextFormField(
                controller: tempoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Tempo',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addTask(
                  textController.text,
                  int.parse(tempoController.text),
                );
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
