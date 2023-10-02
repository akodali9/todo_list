import 'package:flutter/material.dart';
import 'package:todo_list/features/tasks/services/notedit.dart';
import 'package:todo_list/models/note_model.dart';

class NoteEditPage extends StatelessWidget {
  const NoteEditPage({
    Key? key,
    this.note,
    this.index,
  }) : super(key: key);
  static const String routename = "/note-edit";
  final NoteModel? note;
  final int? index;

  @override
  Widget build(BuildContext context) {
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController notecontroller = TextEditingController();
    bool newnotecheck = true;
    String dummytitle;
    String dummynoteDesc;
    if (note != null) {
      newnotecheck = false;
      titlecontroller.text = note!.title;
      notecontroller.text = note!.noteDesc;
      dummytitle = note!.title;
      dummynoteDesc = note!.noteDesc;
    } else {
      dummytitle = "";
      dummynoteDesc = "";
    }

    void savenote() {
      NoteModel newNote =
          NoteModel(title: titlecontroller.text, noteDesc: notecontroller.text);
      if (newnotecheck) {
        NotesCrudOps.addNewNote(context, newNote);
      } else if (newnotecheck == false) {
        if (newNote.title != "") {
          NotesCrudOps.savePresentNote(context, newNote, index!);
        }
      }
    }

    return WillPopScope(
      onWillPop: (titlecontroller.text != dummytitle)
          ? () async {
              final shouldPop = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Save & Exit'),
                    content: const Text(
                      'You want to save your current changes?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          savenote();
                          Navigator.pop(context, true);
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
              return shouldPop!;
            }
          : null,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
                            onPressed: () {
                              NotesCrudOps.deletenote(context, index!);
                              int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 2;
                              });
                            },
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
                onPressed: () {
                  savenote();
                },
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
      ),
    );
  }
}
