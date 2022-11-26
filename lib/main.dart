import 'package:flutter/material.dart';
import 'package:flutter_views/features/presentations/edit_text/edit_text_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Sample Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EditTextPage(),
    );
  }
}
