import 'package:flutter/material.dart';
import 'models/task.dart';
import 'widgets/task_tile.dart';
import 'screens/add_task_screen.dart';

void main() {
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

  final List<Task> dummyTasks = [
    Task(title: "Complete Flutter project"),
    Task(title: "Apply for internships"),
    Task(title: "Read Flutter documentation"),
  ];

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
              dummyTasks.add(
                Task(
                  title: result["title"],
                  description: result["description"],
                ),
              );
            });
          }

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}