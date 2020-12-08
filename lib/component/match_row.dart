import 'package:flutter/material.dart';
import 'package:guess_score/component/score_stat.dart';
import 'package:guess_score/component/team_logo.dart';
import 'package:guess_score/component/team_stat.dart';
import 'package:guess_score/enum/match_status_enum.dart';
import 'package:guess_score/model/match.dart';

class MatchRow extends StatefulWidget {
  final Map _teamMap;
  final Match _match;
  final int _index;

  MatchRow({@required Map teamMap, @required Match match, int index})
      : _match = match,
        _teamMap = teamMap,
        _index = index;

  @override
  _MatchRowState createState() => _MatchRowState();
}

class _MatchRowState extends State<MatchRow> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetFloat;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
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
    _offsetFloat = Tween<Offset>(
      begin: beginOffset,
      end: endOffset,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant MatchRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Mutlaka match modelinde olduğu gibi Equatable paketini extend etmek lazım
    // yoksa her defa birbirinden farklı olup koşula girer.
    if(oldWidget._match != widget._match){
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetFloat,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TeamStat(
                teamMap: widget._teamMap,
                leagueId: widget._match.competitionId,
                team: widget._match.homeTeam,
              ),
              //teamStat(match.competitionId, match.homeTeam),
              //teamLogo(match.competitionId, match.homeTeam),
              TeamLogo(
                teamMap: widget._teamMap,
                leagueId: widget._match.competitionId,
                team: widget._match.homeTeam,
              ),
              //teamStat(match.competitionId, match.homeTeam),
              SizedBox(
                width: 10,
              ),
              //scoreStat(match),
              ScoreStat(
                match: widget._match,
              ),
              SizedBox(
                width: 10,
              ),
              //teamLogo(match.competitionId, match.awayTeam),
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
              //teamStat(match.competitionId, match.homeTeam),
            ],
          ),
          Text(matchStatusFromString(widget._match.status)
              .getEnumValueAsStringDesc())
        ],
      ),
    );
  }
}
