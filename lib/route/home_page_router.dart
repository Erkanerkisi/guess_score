import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/auth/bloc/auth_bloc.dart';
import 'package:guess_score/auth/bloc/auth_event.dart';
import 'package:guess_score/bet/bet_page.dart';
import 'package:guess_score/live_results/view/results_page.dart';
import 'package:guess_score/profile/profile_page.dart';

class HomePageRouter extends StatefulWidget {
  @override
  _HomePageRouterState createState() => _HomePageRouterState();
}

class _HomePageRouterState extends State<HomePageRouter> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    BetPage(),
    ResultsPage(),
    ProfilePage()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Erkan BET"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Center(
                child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(DoUnAuthenticate());
                    },
                    child: Icon(Icons.logout))),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_sharp), label: "Bets"),
          new BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Live'),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'Profile')
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
