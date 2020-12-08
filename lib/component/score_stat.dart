import 'package:flutter/material.dart';
import 'package:guess_score/utility/utility.dart';
import 'package:guess_score/model/match.dart';

class ScoreStat extends StatelessWidget {

  final Match _match;

  ScoreStat({@required Match match})
      : _match = match;

  @override
  Widget build(BuildContext context) {
    String home = Utility.getValue(_match.score.homeTeamScore);
    String away = Utility.getValue(_match.score.awayTeamScore);
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
}
