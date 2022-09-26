import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/note/list_simple_note.dart';

import 'note/plaform_note.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PlatformNote(),
    );
  }
}
