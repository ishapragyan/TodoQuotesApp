import 'package:flutter/material.dart';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> dummyTasks = const [
    "Complete Flutter project",
    "Apply for internships",
    "Read Flutter documentation"
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
                    title: Text(dummyTasks[index]),
                    trailing: Checkbox(
                      value: false,
                      onChanged: (value) {},
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