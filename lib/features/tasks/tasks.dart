import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_list/features/search/search.dart';
import 'package:todo_list/features/settings/settings_page.dart';
import 'package:todo_list/features/tasks/note_edit_area.dart';
import 'package:todo_list/functions/itemaxisalignmentcount.dart';
import 'package:todo_list/models/drawer_item.dart';
import 'package:todo_list/models/user.dart';
import 'package:todo_list/widgets/drawertile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isGridViewActive});
  final bool isGridViewActive;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<User?> fetchUser() async {
    User? user = await User.loadFromSharedPreferences();
    await Future.delayed(const Duration(milliseconds: 500));
    return user;
  }

  late Future<User?> userModel;

  @override
  void initState() {
    super.initState();
    userModel = fetchUser();
  }

  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.surface;
    Color shadowcolor = Theme.of(context).colorScheme.shadow;
    Color surfaceTint = Theme.of(context).colorScheme.surfaceTint;
    int bordercolor = Theme.of(context).colorScheme.secondary.green;

    List<DrawerItem> drawerCustomItems = [
      DrawerItem(
        icon: const Icon(Icons.feedback),
        name: " Feedback",
        routename: "",
      ),
      DrawerItem(
        icon: const Icon(Icons.settings),
        name: " Settings",
        routename: SettingsPage.routename,
      ),
    ];

    return FutureBuilder(
      future: userModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                height: 5,
                width: 200,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SearchComp(isGridViewActive: widget.isGridViewActive),
              ],
              body: MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data?.notes.length,
                padding: const EdgeInsets.all(8.0),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: widget.isGridViewActive
                    ? crossAxisAlignmentCountItem(context)
                    : 1,
                itemBuilder: (context, index) => Material(
                  borderRadius: BorderRadius.circular(10),
                  shadowColor: shadowcolor,
                  color: color,
                  surfaceTintColor: surfaceTint,
                  elevation: 5.0,
                  child: InkWell(
                    enableFeedback: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteEditPage(
                            note: snapshot.data?.notes[index],
                            index: index,
                          ),
                        ),
                      ).then((value) {
                        setState(() {
                          userModel = fetchUser();
                        });
                      });
                    },
                    onLongPress: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(bordercolor),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.notes[index].title,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(snapshot.data!.notes[index].noteDesc),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            drawer: Drawer(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hello ${snapshot.data!.username}",
                      style: const TextStyle(
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
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }
      },
    );
  }
}
