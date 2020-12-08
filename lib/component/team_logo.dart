import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_score/model/team.dart';

class TeamLogo extends StatelessWidget {
  final Map _teamMap;
  final Team _team;
  final int _leagueId;

  TeamLogo({@required Map teamMap, @required Team team, @required int leagueId})
      : _team = team,
        _teamMap = teamMap,
        _leagueId = leagueId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: SvgPicture.network(
            _teamMap[_leagueId][_team.id].crestUrl,
          ),
        ),
      ],
    );
  }
}
