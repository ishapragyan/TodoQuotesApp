import 'package:flutter/material.dart';
import 'models/task.dart';

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
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    title: Text(dummyTasks[index].title),
                    trailing: Checkbox(
                      value: dummyTasks[index].isCompleted,
                      onChanged: (value) {
                        setState(() {
                          dummyTasks[index].isCompleted = value!;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}