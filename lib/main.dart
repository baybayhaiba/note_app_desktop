import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/provider/crud_notes_provider.dart';
import 'package:note_app/screen/home.dart';
import 'package:note_app/theme/note_theme.dart';
import 'package:provider/provider.dart';

import 'system/firebase_options.dart';

const String projectId = "noteapp-86f00";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ///await Firebase.initializeApp(name: projectId);

  runApp(MultiProvider(
    child: const MyApp(),
    providers: [ChangeNotifierProvider(create: (_) => CrudNotesProvider())],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: NoteTheme.dark(),
      home: const Home(),
    );
  }
}
