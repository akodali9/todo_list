import 'package:flutter/material.dart';
import 'package:todo_list/models/note_model.dart';

class NoteEditPage extends StatelessWidget {
  const NoteEditPage({super.key, this.note, this.index});
  static const String routename = "/note-edit";
  final NoteModel? note;
  final int? index;

  @override
  Widget build(BuildContext context) {
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController notecontroller = TextEditingController();

    if (note != null) {
      titlecontroller.text = note!.title;
      notecontroller.text = note!.noteDesc;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Are you sure?"),
                      actions: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Yes",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red[400],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 24),
              controller: titlecontroller,
              decoration: const InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(
                  fontSize: 24,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 500,
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                style: const TextStyle(fontSize: 18),
                controller: notecontroller,
                decoration: const InputDecoration(
                  hintText: "Note",
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
