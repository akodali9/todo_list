import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_list/functions/itemaxisalignmentcount.dart';
import 'package:todo_list/models/note_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, required this.isGridViewActive});
  final bool isGridViewActive;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    List<NoteModel> itemlist = [
      NoteModel(
        title: "title 1",
        noteDesc:
            "This is note description 1. works perfect but need to render the item again",
      ),
      NoteModel(
        title: "title 2",
        noteDesc: "This is note description 1",
      ),
      NoteModel(
        title: "title 3",
        noteDesc:
            "This is note description 1 blahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblah",
      ),
      NoteModel(
        title: "title 4",
        noteDesc: "This is note description 1. I think this is something good ",
      ),
      NoteModel(
        title: "title 5",
        noteDesc:
            "This is note description 1. blah blah blah blah blah blahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblah blah",
      ),
      NoteModel(
        title: "title 6",
        noteDesc: "This is note description 1",
      ),
    ];

    final Color color = Theme.of(context).colorScheme.surface;
    Color shadowcolor = Theme.of(context).colorScheme.shadow;
    Color surfaceTint = Theme.of(context).colorScheme.surfaceTint;
    int bordercolor = Theme.of(context).colorScheme.secondary.green;

    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      itemCount: itemlist.length,
      padding: const EdgeInsets.all(8.0),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount:
          widget.isGridViewActive ? crossAxisAlignmentCountItem(context) : 1,
      itemBuilder: (context, index) => Material(
        borderRadius: BorderRadius.circular(10),
        shadowColor: shadowcolor,
        color: color,
        surfaceTintColor: surfaceTint,
        elevation: 5.0,
        child: InkWell(
          enableFeedback: true,
          onTap: () {},
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
                  itemlist[index].title,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(itemlist[index].noteDesc),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
