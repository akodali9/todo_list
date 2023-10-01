// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoteModel {
  final String title;
  final String noteDesc;

  NoteModel({required this.title, required this.noteDesc});

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'noteDesc': noteDesc,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'] as String,
      noteDesc: map['noteDesc'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) => NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
