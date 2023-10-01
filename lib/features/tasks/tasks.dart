import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_list/features/tasks/note_edit_area.dart';
import 'package:todo_list/functions/itemaxisalignmentcount.dart';
import 'package:todo_list/models/note_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen(
      {super.key, required this.isGridViewActive, required this.tasksList});
  final bool isGridViewActive;
  final List<NoteModel> tasksList;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.surface;
    Color shadowcolor = Theme.of(context).colorScheme.shadow;
    Color surfaceTint = Theme.of(context).colorScheme.surfaceTint;
    int bordercolor = Theme.of(context).colorScheme.secondary.green;

    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.tasksList.length,
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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NoteEditPage(
                          note: widget.tasksList[index],
                          index: index,
                        )));
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
                  widget.tasksList[index].title,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.tasksList[index].noteDesc),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
