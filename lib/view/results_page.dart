import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/model/match.dart';
import 'package:guess_score/model/team.dart';
import 'package:guess_score/service/init/init.dart';
import 'package:guess_score/service/match/match_service.dart';
import 'package:guess_score/utility/utility.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final MatchService _matchService = MatchService();
  DateTime firstDate;

  DateTime lastDate;
  final _fController = TextEditingController();
  final _sController = TextEditingController();
  Map<int, Map<int, Team>> teamMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _fController,
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2025))
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          firstDate = value;
                        });
                        _fController.text =
                            Utility.dateToStringWithRequiredFormat(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'İlk Tarih'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _sController,
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2025))
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          lastDate = value;
                        });
                        _sController.text =
                            Utility.dateToStringWithRequiredFormat(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Son Tarih'),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: FutureBuilder(
            future: getMatches(firstDate, lastDate),
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
            SizedBox(width: 10,),
            scoreStat(match),
            SizedBox(width: 10,),
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

  Future getMatches(fDate, lDate) {
    return _matchService.findByInCompetitionAndFromDateAndToDate(
        Constants.LEAGUES, fDate, lDate);
  }

  @override
  void initState() {
    teamMap = Init.teamMap;
    firstDate = DateTime.now().subtract(Duration(days: 15));
    lastDate = DateTime.now().subtract(Duration(days: 8));
    _fController.text = Utility.dateToStringWithRequiredFormat(
        DateTime.now().subtract(Duration(days: 15)));
    _sController.text = Utility.dateToStringWithRequiredFormat(
        DateTime.now().subtract(Duration(days: 8)));
  }
}
