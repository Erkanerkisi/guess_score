import 'package:flutter/material.dart';
import 'file:///C:/erkan/projects/guess_score/lib/live_results/view/results_page.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("Erkan Bet")), body: ResultsPage()),
    );
  }
}
