import 'package:flutter/material.dart';
import 'models/task.dart';
import 'widgets/task_tile.dart';
import 'screens/add_task_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('tasks');

  runApp(const TodoQuotesApp());
}

class TodoQuotesApp extends StatelessWidget {
  const TodoQuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Motivation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Box<Task> taskBox;
  List<Task> dummyTasks = [];

  @override
  void initState() {
    super.initState();

    taskBox = Hive.box<Task>('tasks');
    dummyTasks = taskBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        centerTitle: true,
      ),
      body: Column(
        children: [

          /// Quote Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Stay motivated! Your productivity journey starts today.",
              style: TextStyle(fontSize: 16),
            ),
          ),

          /// Task List
          Expanded(
            child: ListView.builder(
              itemCount: dummyTasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: dummyTasks[index],
                  onChanged: (value) {
                    setState(() {
                      dummyTasks[index].isCompleted = value!;
                      taskBox.putAt(index, dummyTasks[index]);
                    });
                  },
                );
              },
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );

          if (result != null) {
            setState(() {
              final newTask = Task(
                title: result["title"],
                description: result["description"],
              );

              taskBox.add(newTask);

              dummyTasks = taskBox.values.toList();
            });
          }

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}