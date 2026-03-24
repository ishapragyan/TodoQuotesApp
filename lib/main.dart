import 'package:flutter/material.dart';
import 'models/task.dart';
import 'widgets/task_tile.dart';
import 'screens/add_task_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'providers/quote_provider.dart';
import 'services/notification_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('tasks');

  await NotificationService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => QuoteProvider()),
      ],
      child: const TodoQuotesApp(),
    ),
  );
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

    Future.microtask(() {
      Provider.of<QuoteProvider>(context, listen: false).fetchQuote();
    });
  }



  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final quoteProvider = Provider.of<QuoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        centerTitle: true,
      ),
      body: Column(
        children: [

          /// Quote Card
          Consumer<QuoteProvider>(
            builder: (context, quoteProvider, child) {
              return Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [

                    Text(
                      quoteProvider.quote,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "- ${quoteProvider.author}",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    const SizedBox(height: 10),

                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        quoteProvider.fetchQuote();
                      },
                    )
                  ],

                ),
              );
            },
          ),

          /// Task List
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: taskProvider.tasks[index],
                  onChanged: (value) {
                    setState(() {
                      taskProvider.toggleTask(index);
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
            taskProvider.addTask(
              result["title"],
              result["description"],
            );
          }

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}