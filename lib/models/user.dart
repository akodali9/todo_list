// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/note_model.dart';

class User {
  String username;
  final String email;
  final String password;
  List<NoteModel> notes;

  User({
    this.username = '',
    required this.email,
    required this.password,
    List<NoteModel>? notes,
  }) : notes = notes ?? [];

  Future<void> saveToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userJsonString = jsonEncode(toMap());
    await prefs.setString('user', userJsonString);
  }

  // Add a static method to load the user from SharedPreferences
  static Future<User?> loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userJsonString = prefs.getString('user');
    // print(userJsonString);

    if (userJsonString != null) {
      final userMap = jsonDecode(userJsonString);
      return User.fromMap(userMap);
    } else {
      return null; // If no user data found in SharedPreferences
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'notes': notes.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      notes: List<NoteModel>.from(
        (map['notes'] as List<dynamic>).map<NoteModel>(
          (x) => NoteModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
