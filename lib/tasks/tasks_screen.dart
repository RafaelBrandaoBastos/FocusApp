import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/navbar-and-menus/bottom_navigation_bar.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Task {
  final String text;

  Task(this.text);
}

class TaskManager {
  static const _tasksKey = 'tasks';

  static Future<void> addTask(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList(_tasksKey) ?? [];
    tasks.add(task.text);
    await prefs.setStringList(_tasksKey, tasks);
  }

  static Future<List<Task>> getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList(_tasksKey) ?? [];
    return tasks.map((text) => Task(text)).toList();
  }
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late List<Task> _tasks;

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

  Future<void> _addTask(String text) async {
    Task task = Task(text);
    await TaskManager.addTask(task);
    setState(() {
      _tasks.add(task);
    });
  }

  Future<void> _deleteTask(int index) async {
    setState(() {
      _tasks.removeAt(index);
    });
    await _saveTasks();
  }

  Future<void> _modifyTask(int index) async {
  TextEditingController textController =
      TextEditingController(text: _tasks[index].text);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Modify Task'),
        content: TextFormField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: 'Task',
          ),
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
              setState(() {
                _tasks[index] = Task(textController.text);
              });
              _saveTasks();
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

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskTexts = _tasks.map((task) => task.text).toList();
    await prefs.setStringList(TaskManager._tasksKey, taskTexts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Tasks')),
        backgroundColor: LightModeBackgroundColor,
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppLightBlue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(_tasks[index].text),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskModal(context);
        },
        backgroundColor: LightModeBackgroundColor,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 1,
        onItemTapped: (index) {
        },
      ),
    );
  }

  void _showAddTaskModal(BuildContext context) {
    TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextFormField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: 'Task',
            ),
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
                _addTask(textController.text);
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
