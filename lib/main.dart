import 'package:flutter/material.dart';
import 'package:todo_list/components/navigation.dart';
import 'package:todo_list/features/tasks/tasks.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(),
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: Tasks_Screen(),
        bottomNavigationBar: const BottomCustomAppBar(),
        floatingActionButton: FloatingActionButton(
          enableFeedback: true,
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        drawer: Drawer(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(onPressed: () {}, child: const Text("I see red")),
            TextButton(onPressed: () {}, child: const Text("I see red")),
            TextButton(onPressed: () {}, child: const Text("I see red")),
          ]),
        ),
      ),
    );
  }
}
