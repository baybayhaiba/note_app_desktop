import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../model/note.dart';
import 'note_simple.dart';

class ListSimpleNote extends StatefulWidget {
  const ListSimpleNote({Key? key}) : super(key: key);

  @override
  State<ListSimpleNote> createState() => _ListSimpleNotState();
}

class _ListSimpleNotState extends State<ListSimpleNote> {
  final uuid = "6d58fff377a05ee8";
  final notes = <Note>[];

  @override
  void initState() {
    FirebaseDatabase.instance.ref("notes").get().then((snapshotData) {
      final notesFirebase = ((snapshotData.value as Map)[uuid] as List).map((e) => Note.fromMap(e));

      setState(() {
        notes.addAll(notesFirebase);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ListView.separated(
      itemBuilder: (context, item) => NoteSimple(note: notes[item]),
      separatorBuilder: (context, item) => const SizedBox(height: 16),
      itemCount: notes.length);
}
