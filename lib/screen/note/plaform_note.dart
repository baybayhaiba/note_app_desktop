import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/note/list_simple_note.dart';
import 'package:note_app/screen/note/note_edit.dart';

class PlatformNote extends StatefulWidget {
  const PlatformNote({Key? key}) : super(key: key);

  @override
  State<PlatformNote> createState() => _PlatformNoteState();
}

class _PlatformNoteState extends State<PlatformNote> {
  bool isCollapse = true;

  final keyEdit = GlobalKey<NoteEditState>();

  @override
  Widget build(BuildContext context) {
    Widget? platformScreen;

    if (kIsWeb) {
      platformScreen = _web(context: context);
    } else if (Platform.isAndroid || Platform.isIOS) {
      platformScreen = _phone(context: context);
    }

    return platformScreen ?? Container(color: Colors.red);
  }

  Widget _phone({required BuildContext context}) => const ListSimpleNote();

  Widget _web({required BuildContext context}) => Row(
        children: [
          Expanded(
            flex: 3,
            child: ListSimpleNote(onClick: (note) => keyEdit.currentState?.updateNote(note)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isCollapse = !isCollapse;
                  });
                },
                icon: const Icon(Icons.navigate_next_sharp)),
          ),
          Visibility(
              visible: isCollapse,
              child: Expanded(
                  flex: 7,
                  child: NoteEdit(
                    key: keyEdit,
                  ))),
        ],
      );
}
