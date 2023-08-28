import 'package:flutter/material.dart';

class NoteEditPage extends StatelessWidget {
  const NoteEditPage({super.key});
  static const String routename = "/note-edit";

  @override
  Widget build(BuildContext context) {
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController notecontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
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
                style: const TextStyle(fontSize: 20),
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
