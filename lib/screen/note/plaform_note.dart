import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/note/list_simple_note.dart';
import 'package:note_app/screen/note/note_edit.dart';

class PlatformNote extends StatelessWidget {
  const PlatformNote({Key? key}) : super(key: key);

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
        children: const [
          Expanded(
            flex: 3,
            child: ListSimpleNote(),
          ),
          Expanded(flex: 7, child: NoteEdit()),
        ],
      );
}
