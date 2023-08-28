import 'package:flutter/material.dart';
import 'package:todo_list/components/navigation.dart';
import 'package:todo_list/features/tasks/note_edit_area.dart';
import 'package:todo_list/features/tasks/tasks.dart';
import 'package:todo_list/models/drawer_item.dart';
import 'package:todo_list/router.dart';
import 'package:todo_list/widgets/drawertile.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    List<DrawerItem> drawerCustomItems = [
      DrawerItem(
        icon: const Icon(Icons.feedback),
        name: " Feedback",
        onpress: () {},
      ),
      DrawerItem(
        icon: const Icon(Icons.settings),
        name: " Settings",
        onpress: () {},
      ),
    ];
    return MaterialApp(
      title: "Todo Time",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(),
      ),
      onGenerateRoute: (settings) => generateRoutes(settings),
      home: Scaffold(
        appBar: AppBar(),
        body: const TasksScreen(),
        bottomNavigationBar: const BottomCustomAppBar(),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              enableFeedback: true,
              onPressed: () {
                Navigator.of(context).pushNamed(NoteEditPage.routename);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text("Entered Editing page"),
                  ),
                );
              },
              child: const Icon(Icons.add),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        drawer: Drawer(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "TODO Time",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Column(
                  children: drawerCustomItems
                      .map((item) => DrawerTileCustom(item: item))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
