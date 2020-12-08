import 'package:flutter/material.dart';
import 'package:guess_score/model/team.dart';

class TeamStat extends StatelessWidget {
  final Map _teamMap;
  final Team _team;
  final int _leagueId;

  TeamStat({@required Map teamMap, @required Team team, @required int leagueId})
      : _team = team,
        _teamMap = teamMap,
        _leagueId = leagueId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                _teamMap[_leagueId][_team.id].shortName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
