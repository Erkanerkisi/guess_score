import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/live_results/cubit/live_results_cubit.dart';
import 'package:guess_score/live_results/cubit/live_results_state.dart';
import 'package:guess_score/model/match.dart';
import 'package:guess_score/model/team.dart';
import 'package:guess_score/service/init/init.dart';
import 'package:guess_score/service/match/match_service.dart';
import 'package:guess_score/utility/utility.dart';

class ResultsView extends StatefulWidget {
  @override
  _ResultsViewState createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  Map<int, Map<int, Team>> teamMap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveResultsCubit, LiveResultsState>(
        builder: (context, state) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: state.fController,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: Constants.CALENDAR_NOW,
                              firstDate: Constants.CALENDAR_FIRST,
                              lastDate: Constants.CALENDAR_LAST)
                          .then((value) {
                        if (value != null) {
                          context.read<LiveResultsCubit>().setFirstDate(value);
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
                    controller: state.sController,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: Constants.CALENDAR_NOW,
                              firstDate: Constants.CALENDAR_FIRST,
                              lastDate: Constants.CALENDAR_LAST)
                          .then((value) {
                        if (value != null) {
                          context.read<LiveResultsCubit>().setLastDate(value);
                        }
                      });
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Son Tarih'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text("Filter"),
                      onPressed: () {
                        context.read<LiveResultsCubit>().setMatches();
                        setState(() {});
                      },
                    )),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: state.matches,
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
    });
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

  @override
  void initState() {
    teamMap = Init.teamMap;
  }
}
