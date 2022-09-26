import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/provider/crud_notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NoteEdit extends StatefulWidget {
  const NoteEdit({
    Key? key,
  }) : super(key: key);

  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {
  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();
  final _keyForm = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 16),
          child: FloatingActionButton(
              onPressed: onClickFab,
              child: const Icon(kIsWeb ? Icons.done : Icons.add)),
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
      context.read<CrudNotesProvider>().insertNote(_note);
      clearNote();
    }
  }

  String? validator(String? text) =>
      text?.isNotEmpty == true ? null : "Làm ơn không bỏ trống";

  void clearNote() {
    _controllerTitle.clear();
    _controllerDescription.clear();
  }

  Note get _note => Note(
      title: _controllerTitle.text,
      description: _controllerDescription.text,
      timeAgo: DateTime.now().millisecondsSinceEpoch,
      noteType: NoteType.Normal);
}
