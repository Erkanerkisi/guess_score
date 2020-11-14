import 'package:flutter/material.dart';
import 'package:guess_score/view/results_page.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: ResultsPage()),
    );
  }
}
