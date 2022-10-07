import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';

class CrudNotesProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final notes = <Note>[];
  final uuid = "6d58fff377a05ee8";

  DatabaseReference get ref => FirebaseDatabase.instance.ref("notes/$uuid");

  int get id {
    int maxId =
        notes.fold(0, (value, element) => value > (element.id ?? 0) ? value : element.id ?? 0);
    return maxId + 1;
  }

  void startObserverNoteFormFirebase() {
    ref.onChildAdded.listen((event) {
      final snapshot = event.snapshot;
      final map = snapshot.value as Map?;

      if (map == null) return;

      final noteAdded = Note.fromMap(map);

      notes.insert(0, noteAdded);

      notifyListeners();
    });

    ref.onChildRemoved.listen((event) {
      final snapshot = event.snapshot;
      final map = snapshot.value as Map?;

      if (map == null) return;

      final noteRemoved = Note.fromMap(map);

      notes.removeAt(notes.indexOf(noteRemoved));

      notifyListeners();
    });

    ref.onChildChanged.listen((event) {
      final snapshot = event.snapshot;
      final map = snapshot.value as Map?;

      if (map == null) return;

      final noteChange = Note.fromMap(map);

      var noteIndex = notes.indexOf(noteChange);

      notes[noteIndex] = noteChange;

      notifyListeners();
    });
  }

  void startReadNoteFormFirebase() {
    ref.orderByChild("id").get().then((snapshot) {
      final notesFirebase = (snapshot.value as List).map((e) => Note.fromMap(e as Map)).toList();

      _sortNote(notesFirebase);

      notes.clear();
      notes.addAll(notesFirebase);
      notifyListeners();
    });
  }

  void _sortNote(List<Note> notesFirebase) {
    notesFirebase.sort(
      (a, b) => (a.id ?? 0) >= (b.id ?? 0) ? -1 : 1,
    );
  }

  void insertNote(Note note) async {
    await ref.child("${notes.length}").update(note.copyWith(id: id).toMap());
  }

  void updateNote(Note note) async {
    print("hhahahahha => path ${(notes.length - 1) - notes.indexOf(note)} ---- ${note}");

    await ref.child("${(notes.length - 1) - notes.indexOf(note)}").update(note.toMap());
  }

  void deleteNote(Note note) async {
    await ref.child("${(notes.length - 1) - notes.indexOf(note)}").remove();
  }
}
