import 'package:flutter/material.dart';
import 'package:guess_score/component/score_stat.dart';
import 'package:guess_score/component/team_logo.dart';
import 'package:guess_score/component/team_stat.dart';
import 'package:guess_score/enum/match_status_enum.dart';
import 'package:guess_score/model/match.dart';
import 'package:guess_score/utility/utility.dart';

class MatchRowBetDetail extends StatefulWidget {
  final Map _teamMap;
  final Map _guessesMap;
  final Match _match;
  final int _index;

  MatchRowBetDetail({@required Map teamMap,@required Map guessesMap, @required Match match, int index})
      : _match = match,
        _teamMap = teamMap,
        _guessesMap = guessesMap,
        _index = index;

  @override
  _MatchRowBetDetailState createState() => _MatchRowBetDetailState();
}

class _MatchRowBetDetailState extends State<MatchRowBetDetail> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offsetFloat;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    var beginOffset ;
    var endOffset;

    if (widget._index % 2 == 0) {
      beginOffset = Offset(-1, 0);
      endOffset = Offset(0, 0);
    } else {
      beginOffset = Offset(1, 0);
      endOffset = Offset(0, 0);
    }
    offsetFloat = Tween<Offset>(
      begin: beginOffset,
      end: endOffset,
    ).animate(controller);

    controller.forward();
  }

  @override
  void didUpdateWidget(covariant MatchRowBetDetail oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Mutlaka match modelinde olduğu gibi Equatable paketini extend etmek lazım
    // yoksa her defa birbirinden farklı olup koşula girer.
    if(oldWidget._match != widget._match){
      controller.reset();
      controller.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Icon matchResultIcons(Match match) {
    int result = Utility.convertResultToNumber(match.winner);
    return result != null && result == widget._guessesMap[match.id]
        ? Icon(
      Icons.done,
      color: Colors.green,
    )
        : result != null && result != widget._guessesMap[match.id]
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
    return Text("Guess: " + widget._guessesMap[match.id].toString());
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offsetFloat,
      child: Column(
        children: [
          Text(matchStatusFromString(widget._match.status).getEnumValueAsStringDesc()),
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
              TeamStat(
                teamMap: widget._teamMap,
                leagueId: widget._match.competitionId,
                team: widget._match.homeTeam,
              ),
              TeamLogo(
                teamMap: widget._teamMap,
                leagueId: widget._match.competitionId,
                team: widget._match.homeTeam,
              ),
              SizedBox(
                width: 10,
              ),
              ScoreStat(
                match: widget._match,
              ),
              SizedBox(
                width: 10,
              ),
              TeamLogo(
                teamMap: widget._teamMap,
                leagueId: widget._match.competitionId,
                team: widget._match.awayTeam,
              ),
              //teamStat(match.competitionId, match.homeTeam),
              //teamStat(match.competitionId, match.awayTeam)
              TeamStat(
                teamMap: widget._teamMap,
                leagueId: widget._match.competitionId,
                team: widget._match.awayTeam,
              ),
              matchResultIcons(widget._match),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              guessRow(widget._match),
            ],
          ),
        ],
      ),
    );
  }
}
