import 'package:flutter/material.dart';
import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/model/matches.dart';
import 'package:guess_score/model/match.dart';
import 'package:guess_score/service/match/match_service.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final MatchService _matchService = MatchService();
  Matches matches;

  @override
  Widget build(BuildContext context) {
    if(matches == null)
      return CircularProgressIndicator();

    return ListView.builder(
      itemCount: matches.count,
      itemBuilder: (context, index) {
        return matchRow(matches.matchList[index]);
      },
    );
  }

  Widget matchRow(Match match) {
    return Row(
      children: [
        Center(
          child: Text(match.homeTeam.name),
        )
      ],
    );
  }

  @override
  void initState() {
    _matchService
        .findByInCompetitionAndFromDateAndToDate(
            Constants.LEAGUES, DateTime.now(), DateTime.now().add(Duration(days: 8)))
        .then((value) => setState(() {
              matches = value;
            }));
  }
}
