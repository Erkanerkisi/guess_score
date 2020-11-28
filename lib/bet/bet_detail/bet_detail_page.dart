import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_score/model/match.dart';
import 'package:guess_score/model/matches.dart';
import 'package:guess_score/model/mybet.dart';
import 'package:guess_score/model/team.dart';
import 'package:guess_score/service/bet/abtract_bet_service.dart';
import 'package:guess_score/service/bet/default_bet_service.dart';
import 'package:guess_score/service/init/init.dart';
import 'package:guess_score/service/match/abstract_match_service.dart';
import 'package:guess_score/service/match/match_service.dart';
import 'package:guess_score/utility/utility.dart';

class BetDetailPage extends StatefulWidget {
  MyBet myBet;

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

  @override
  void initState() {
    _matchIdList = widget.myBet.content.map((e) => e.matchid).toList();
    _matchService = MatchService();
    teamMap = Init.teamMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    itemCount: snapshot.data.count,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(15.0),
                        child: matchRow(snapshot.data.matchList[index]),
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
        )
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
