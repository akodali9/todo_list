import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/navigation.dart';
import 'package:todo_list/features/tasks/note_edit_area.dart';
import 'package:todo_list/features/tasks/tasks.dart';
import 'package:todo_list/models/drawer_item.dart';
import 'package:todo_list/providers/user_provider.dart';
import 'package:todo_list/router.dart';
import 'package:todo_list/widgets/drawertile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserSettings(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

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
  late bool gridIconBool;

  @override
  void initState() {
    super.initState();
    gridIconBool = UserSimplePreferences.loadData() ?? false;
  }

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
              SliverAppBar(
                floating: true,
                scrolledUnderElevation: 1,
                snap: true,
                title: const Text("Your Notes"),
                actions: [
                  if (gridIconBool == true)
                    IconButton(
                        tooltip: "Single-Column view",
                        onPressed: () {
                          Provider.of<UserSettings>(context, listen: false)
                              .setGridIconBool(false);
                        },
                        icon: const RotatedBox(
                            quarterTurns: 1,
                            child: Icon(Icons.view_column_outlined)))
                  else
                    IconButton(
                        tooltip: "Grid view",
                        onPressed: () {
                          Provider.of<UserSettings>(context, listen: false)
                              .setGridIconBool(true);
                        },
                        icon: const Icon(Icons.grid_view_outlined)),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: IconButton(
                      tooltip: "Search",
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ],
            body: TasksScreen(gridViewBool: gridIconBool),
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
