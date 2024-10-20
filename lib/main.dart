import 'package:flutter/material.dart';
import 'contact_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Agenda',
      theme: ThemeData.dark(),  // Dark mode enabled
      home: ContactListScreen(),
    );
  }
}