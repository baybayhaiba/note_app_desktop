import 'package:flutter/material.dart';

import '../../model/note.dart';

class NoteSimple extends StatelessWidget {
  const NoteSimple({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note?.title ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 16),
                Text(note?.description ?? ""),
                const SizedBox(height: 16),
                Container(
                    color: Colors.transparent,
                    alignment: Alignment.centerRight,
                    child: Text(note?.noteType?.name ?? "")),
              ]),
        ),
      );
}
