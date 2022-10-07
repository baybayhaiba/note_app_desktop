import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/provider/crud_notes_provider.dart';
import 'package:provider/provider.dart';

import 'note_edit.dart';
import 'note_simple.dart';

class ListSimpleNote extends StatefulWidget {
  const ListSimpleNote({Key? key, this.onClick}) : super(key: key);

  final Function(Note)? onClick;

  @override
  State<ListSimpleNote> createState() => _ListSimpleNotState();
}

class _ListSimpleNotState extends State<ListSimpleNote> {
  CrudNotesProvider get provider => context.read<CrudNotesProvider>();



  @override
  void initState() {
    provider.startObserverNoteFormFirebase();
    provider.startReadNoteFormFirebase();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Consumer<CrudNotesProvider>(
        builder: (context, value, child) => ListView.separated(
            itemBuilder: (context, item) => InkWell(
                onLongPress: () {
                  provider.deleteNote(value.notes[item]);
                },
                onTap: () {
                  widget.onClick?.call(value.notes[item]);
                },
                child: NoteSimple(note: value.notes[item])),
            separatorBuilder: (context, item) => const SizedBox(height: 16),
            itemCount: value.notes.length),
      );
}
