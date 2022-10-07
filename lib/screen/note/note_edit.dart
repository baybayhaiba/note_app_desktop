import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/provider/crud_notes_provider.dart';
import 'package:provider/provider.dart';

class NoteEdit extends StatefulWidget {
  const NoteEdit({
    Key? key,
  }) : super(key: key);

  @override
  State<NoteEdit> createState() => NoteEditState();
}

class NoteEditState extends State<NoteEdit> {
  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  Note? nodeLocal;

  void updateNote(Note note) {
    nodeLocal = note;
    _controllerTitle.text = note.title ?? "";
    _controllerDescription.text = note.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 16),
          child: FloatingActionButton(
              onPressed: onClickFab, child: const Icon(kIsWeb ? Icons.done : Icons.add)),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.disabled,
              validator: validator,
              controller: _controllerTitle,
              decoration: const InputDecoration(label: Text("Tiêu đề")),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextFormField(
                autovalidateMode: AutovalidateMode.disabled,
                maxLines: null,
                validator: validator,
                textAlignVertical: TextAlignVertical.top,
                controller: _controllerDescription,
                decoration: const InputDecoration(label: Text("Nội dung")),
                expands: true,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void onClickFab() {
    if (_keyForm.currentState?.validate() == true) {
      nodeLocal = nodeLocal?.copyWith(
              title: _controllerTitle.text, description: _controllerDescription.text) ??
          _note;
      if (nodeLocal?.id != null) {
        context.read<CrudNotesProvider>().updateNote(nodeLocal!);
      } else {
        context.read<CrudNotesProvider>().insertNote(nodeLocal!);
      }

      clearNote();
    }
  }

  String? validator(String? text) => text?.isNotEmpty == true ? null : "Làm ơn không bỏ trống";

  void clearNote() {
    nodeLocal = null;
    _controllerTitle.clear();
    _controllerDescription.clear();
  }

  Note get _note => Note(
      title: _controllerTitle.text,
      description: _controllerDescription.text,
      time: DateTime.now().millisecondsSinceEpoch,
      noteType: NoteType.Normal);
}
