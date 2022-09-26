import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';

class CrudNotesProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final notes = <Note>[];
  final uuid = "6d58fff377a05ee8";

  void startReadNoteFormFirebase() {
    FirebaseDatabase.instance.ref("notes").get().then((snapshotData) {
      final notesFirebase = ((snapshotData.value as Map)[uuid] as List)
          .map((e) => Note.fromMap(e));
      notes.addAll(notesFirebase);

      notifyListeners();
    });
  }

  void insertNote(Note note) {
    notes.insert(0, note);

    notifyListeners();
  }

  void updateNote(Note note) {
    print("Update note hacker lo~ => ${note.toJson()}");
  }

  void deleteNote(Note note) {
    print("Delete note hacker lo~ => ${note.toJson()}");
  }
}
