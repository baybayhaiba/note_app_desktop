import 'package:flutter/material.dart';
import 'package:note_app/theme/note_theme.dart';

import '../../model/note.dart';

class NoteSimple extends StatelessWidget {
  const NoteSimple({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note?.title ?? "",
                  style: NoteTheme.darkTextTheme.headline2,
                ),
                const SizedBox(height: 16),
                Text(note?.description ?? ""),
                const SizedBox(height: 16),
                Container(
                    alignment: Alignment.centerRight,
                    child: Text(note?.noteType?.name ?? "",style: NoteTheme.darkTextTheme.bodySmall,)),
              ]),
        ),
      );
}
