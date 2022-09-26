import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:note_app/provider/crud_notes_provider.dart';
import 'package:provider/provider.dart';

import '../../model/note.dart';
import 'note_simple.dart';

class ListSimpleNote extends StatefulWidget {
  const ListSimpleNote({Key? key}) : super(key: key);

  @override
  State<ListSimpleNote> createState() => _ListSimpleNotState();
}

class _ListSimpleNotState extends State<ListSimpleNote> {
  CrudNotesProvider get provider => context.read<CrudNotesProvider>();

  @override
  void initState() {
    provider.startReadNoteFormFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Consumer<CrudNotesProvider>(
        builder: (context, value, child) => ListView.separated(
            itemBuilder: (context, item) => NoteSimple(note: value.notes[item]),
            separatorBuilder: (context, item) => const SizedBox(height: 16),
            itemCount: value.notes.length),
      );
}
