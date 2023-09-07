import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/navigation.dart';
import 'package:todo_list/features/search/search.dart';
import 'package:todo_list/features/tasks/note_edit_area.dart';
import 'package:todo_list/features/tasks/tasks.dart';
import 'package:todo_list/models/drawer_item.dart';
import 'package:todo_list/providers/grid_provider.dart';
import 'package:todo_list/router.dart';
import 'package:todo_list/widgets/drawertile.dart';

import 'providers/user_simple_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isGridPrevActive =
      await UserSimplePreferences.loadGridActiveData() ?? true;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GridSettings(isGridPrevActive),
        ),
      ],
      child: MainApp(isGridPrevActive: isGridPrevActive),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.isGridPrevActive});

  final bool isGridPrevActive;
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // final Color schemaColorHex = const Color(0XFF1f1f1f);
  final Color schemaColorHex = const Color(0XFF0f2546);
  int crossAxisCount = 1;

  // void gridAligment() {
  //   setState(() {
  //     gridIconBool = false;
  //   });
  // }

  // void colAligment() {
  //   setState(() {
  //     gridIconBool = true;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

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
    bool isGridViewActive = Provider.of<GridSettings>(context).isGridActive;
    return MaterialApp(
      title: "Todo Time",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // colorSchemeSeed: const Color(0XFF071120),
        colorSchemeSeed: schemaColorHex,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        // colorSchemeSeed: const Color(0XFF071120),
        colorSchemeSeed: schemaColorHex,
        brightness: Brightness.dark,
      ),
      onGenerateRoute: (settings) => generateRoutes(settings),
      home: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SearchComp(isGridViewActive: isGridViewActive),
            ],
            body: TasksScreen(isGridViewActive: isGridViewActive),
          ),
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
      ),
    );
  }
}
