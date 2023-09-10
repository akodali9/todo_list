import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/navigation.dart';
import 'package:todo_list/features/auth/auth_screen.dart';
import 'package:todo_list/features/search/search.dart';
import 'package:todo_list/features/settings/settings_page.dart';
import 'package:todo_list/features/tasks/note_edit_area.dart';
import 'package:todo_list/features/tasks/tasks.dart';
import 'package:todo_list/models/drawer_item.dart';
import 'package:todo_list/providers/grid_provider.dart';
import 'package:todo_list/providers/user_provider.dart';
import 'package:todo_list/router.dart';
import 'package:todo_list/widgets/drawertile.dart';

import 'providers/user_simple_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isGridPrevActive =
      await UserSimplePreferences.loadGridActiveData() ?? true;
  String usertoken = await UserSimplePreferences.loadUserToken() ?? "";
  runApp(
    MultiProvider(
      providers: [
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => GridSettings(isGridPrevActive),
            ),
            ChangeNotifierProvider(
              create: (context) => UserProvider(usertoken),
            ),
          ],
        ),
      ],
      // child: MainApp(isGridPrevActive: isGridPrevActive),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  // final bool isGridPrevActive;
  // final String userAuthToken;
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // bool authstatus = true;
  // final Color schemaColorHex = const Color(0XFF1f1f1f);
  final Color schemaColorHex = const Color(0XFF0f2546);
  int crossAxisCount = 1;

  @override
  Widget build(BuildContext context) {
    List<DrawerItem> drawerCustomItems = [
      DrawerItem(
          icon: const Icon(Icons.feedback),
          name: " Feedback",
          // onpress: () {},
          routename: ""),
      DrawerItem(
        icon: const Icon(Icons.settings),
        name: " Settings",
        // onpress: () => Navigator.of(context).pushNamed(SettingsPage.routename),
        routename: SettingsPage.routename,
      ),
    ];
    bool isGridViewActive = Provider.of<GridSettings>(context).isGridActive;
    String userTokenKey = Provider.of<UserProvider>(context).token;
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
      // home: HomeScreen(isGridViewActive: isGridViewActive, drawerCustomItems: drawerCustomItems),
      home: userTokenKey == ""
          ? const AuthScreen()
          : HomeScreen(
              isGridViewActive: isGridViewActive,
              drawerCustomItems: drawerCustomItems),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.isGridViewActive,
    required this.drawerCustomItems,
  });

  final bool isGridViewActive;
  final List<DrawerItem> drawerCustomItems;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }
}
