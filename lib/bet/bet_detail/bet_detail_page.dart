import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/auth/bloc/auth_bloc.dart';
import 'package:guess_score/auth/bloc/auth_event.dart';
import 'package:guess_score/component/match_row_bet_detail.dart';
import 'package:guess_score/component/root_provider.dart';
import 'package:guess_score/model/matches.dart';
import 'package:guess_score/model/mybet.dart';
import 'package:guess_score/model/team.dart';
import 'package:guess_score/service/init/init.dart';
import 'package:guess_score/service/match/abstract_match_service.dart';
import 'package:guess_score/service/match/match_service.dart';

class BetDetailPage extends StatefulWidget {
  final MyBet myBet;

  BetDetailPage({this.myBet});

  @override
  _BetDetailPageState createState() => _BetDetailPageState();
}

class _BetDetailPageState extends State<BetDetailPage> {
  //kupon detayları ve contenti alıp, tüm match idleri servisten kontrol et.
  List<int> _matchIdList;
  Matches matches;
  IMatchService _matchService;
  Map<int, int> guesses;

  @override
  void initState() {
    guesses = HashMap();
    widget.myBet.content.forEach((element) {
      guesses.putIfAbsent(element.matchid, () => element.guess);
    });
    _matchIdList = widget.myBet.content.map((e) => e.matchid).toList();
    _matchService = MatchService();
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _matchService.findByInMatchId(_matchIdList),
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.all(15.0),
                          child: MatchRowBetDetail(
                              match: snapshot.data[index],
                              teamMap: RootProvider.of(context),
                              guessesMap: guesses,
                              index: index));
                    },
                  );
                else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
