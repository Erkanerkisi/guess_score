import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_score/auth/bloc/auth_bloc.dart';
import 'package:guess_score/auth/bloc/auth_event.dart';
import 'package:guess_score/enum/match_status_enum.dart';
import 'package:guess_score/enum/winner_enum.dart';
import 'package:guess_score/model/match.dart';
import 'package:guess_score/model/matches.dart';
import 'package:guess_score/model/mybet.dart';
import 'package:guess_score/model/team.dart';
import 'package:guess_score/service/init/init.dart';
import 'package:guess_score/service/match/abstract_match_service.dart';
import 'package:guess_score/service/match/match_service.dart';
import 'package:guess_score/utility/utility.dart';

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
  Map<int, Map<int, Team>> teamMap;
  Map<int, int> guesses;

  @override
  void initState() {
    guesses = HashMap();
    widget.myBet.content.forEach((element) {
      guesses.putIfAbsent(element.matchid, () => element.guess);
    });
    _matchIdList = widget.myBet.content.map((e) => e.matchid).toList();
    _matchService = MatchService();
    teamMap = Init.teamMap;
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
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(15.0),
                        child: matchRow(snapshot.data[index]),
                      );
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

  Widget matchRow(Match match) {
    return Column(
      children: [
        Text(matchStatusFromString(match.status).getEnumValueAsStringDesc()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Sondaki iconu sabitlemek için kondu.
            // iconun size ı değişirse bunu da değişmek lazım.
            SizedBox(
              width: 24,
              height: 24,
            ),
            teamStat(match.competitionId, match.homeTeam),
            teamLogo(match.competitionId, match.homeTeam),
            SizedBox(
              width: 10,
            ),
            scoreStat(match),
            SizedBox(
              width: 10,
            ),
            teamLogo(match.competitionId, match.awayTeam),
            teamStat(match.competitionId, match.awayTeam),
            matchResultIcons(match),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            guessRow(match),
          ],
        ),
      ],
    );
  }

  Icon matchResultIcons(Match match) {
    int result = Utility.convertResultToNumber(match.winner);
    return result != null && result == guesses[match.id]
        ? Icon(
            Icons.done,
            color: Colors.green,
          )
        : result != null && result != guesses[match.id]
            ? Icon(
                Icons.clear,
                color: Colors.red,
              )
            : Icon(
                Icons.access_time_outlined,
                color: Colors.blue,
              );
  }

  Widget guessRow(Match match) {
    return Text("Guess: " + guesses[match.id].toString());
  }



  Widget teamStat(int league, Team team) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                teamMap[league][team.id].shortName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget scoreStat(Match match) {
    String home = Utility.getValue(match.score.homeTeamScore);
    String away = Utility.getValue(match.score.awayTeamScore);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$home - $away",
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }

  Widget teamLogo(int competitionId, Team team) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: SvgPicture.network(
            teamMap[competitionId][team.id].crestUrl,
          ),
        ),
      ],
    );
  }
}
