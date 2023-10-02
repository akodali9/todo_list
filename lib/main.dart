import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/features/auth/auth_screen.dart';
import 'package:todo_list/features/search/search.dart';
import 'package:todo_list/features/tasks/note_edit_area.dart';
import 'package:todo_list/features/tasks/tasks.dart';
import 'package:todo_list/providers/grid_provider.dart';
import 'package:todo_list/providers/user_provider.dart';
import 'package:todo_list/router.dart';

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
  final Color schemaColorHex = const Color.fromARGB(255, 201, 239, 255);
  int crossAxisCount = 1;

  @override
  Widget build(BuildContext context) {
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
            ),
    );
  }
}
