import 'package:flutter/material.dart';
import 'package:note_app/screen/note/list_simple_note.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: const ListSimpleNote(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: FloatingActionButton(onPressed: () {},
        child: const Icon(Icons.add)),
      ),
    );
  }
}
