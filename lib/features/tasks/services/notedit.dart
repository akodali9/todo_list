import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/features/auth/auth_service.dart';
import 'package:todo_list/models/note_model.dart';
import 'package:todo_list/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/providers/global_variables.dart';

class NotesCrudOps {
  static Future addNewNote(BuildContext context, NoteModel newnote) async {
    try {
      User? user = await User.loadFromSharedPreferences();
      user?.notes.add(newnote);
      await user?.saveToSharedPreferences();
      if (context.mounted) {
        await syncnotes(context);
      }
    } catch (e) {
      // print(e);
    }
  }

  static Future savePresentNote(
      BuildContext context, NoteModel newnote, int index) async {
    try {
      User? user = await User.loadFromSharedPreferences();
      user?.notes.removeAt(index);
      user?.notes.insert(index, newnote);
      await user?.saveToSharedPreferences();
      if (context.mounted) {
        await syncnotes(context);
      }
    } catch (e) {
      // print(e);
    }
  }

  static Future deletenote(BuildContext context, int index) async {
    try {
      User? user = await User.loadFromSharedPreferences();
      user?.notes.removeAt(index);
      await user?.saveToSharedPreferences();
      if (context.mounted) {
        await syncnotes(context);
      }
    } catch (e) {
      // print(e);
    }
  }

  static Future syncnotes(BuildContext context) async {
    try {
      User? user = await User.loadFromSharedPreferences();
      final Map<String, dynamic> data = {
        "email": user?.email,
        "notes": user?.notes,
      };
      final response = await http.post(
        Uri.parse("$localuri/feature/update"),
        body: json.encode(data),
        headers: AuthService.headers,
      );

      final responsejson = json.decode(response.body);
      if (response.statusCode == 200) {
        // print("succesfull");
      }
    } catch (e) {
      //
    }
  }
}
