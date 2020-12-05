import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_score/enum/match_status_enum.dart';
import 'package:guess_score/model/match.dart';
import 'package:guess_score/model/team.dart';
import 'package:guess_score/utility/utility.dart';

class CustomAnimatedList extends StatefulWidget {
  final List<Match> animatedList;
  final Map teamMap;

  CustomAnimatedList({this.animatedList, this.teamMap});

  @override
  _CustomAnimatedListState createState() => _CustomAnimatedListState();
}

class _CustomAnimatedListState extends State<CustomAnimatedList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<Match> list = <Match>[];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    print("init");
    var future = Future(() {});
    for (var i = 0; i < widget.animatedList.length; i++) {
      print("init for i =" + i.toString());
      future = future.then((_) {
        print("init for i =" + i.toString() + " - future.then");
        return Future.delayed(Duration(milliseconds: 100), () {
          print("init for i =" + i.toString() + " - future.delayed");
          list.add(widget.animatedList[i]);
          _listKey.currentState.insertItem(list.length - 1);
        });
      });
    }
    sleep(Duration(seconds: 5));
    print("init for ended");
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: list.length,
      itemBuilder: (context, index, animation) {
        print("Build itemBuilder");
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset(0, 0),
              ).animate(animation),
              child: matchRow(list[index])),
        );
      },
    );
  }

  Widget matchRow(Match match) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            teamStat(match.competitionId, match.awayTeam)
          ],
        ),
        Text(matchStatusFromString(match.status).getEnumValueAsStringDesc())
      ],
    );
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
                widget.teamMap[league][team.id].shortName,
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
            widget.teamMap[competitionId][team.id].crestUrl,
          ),
        ),
      ],
    );
  }
}
