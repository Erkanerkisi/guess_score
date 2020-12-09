import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/auth/bloc/auth_bloc.dart';
import 'package:guess_score/component/away_circle_button.dart';
import 'package:guess_score/component/create_button.dart';
import 'package:guess_score/component/draw_circle_button.dart';
import 'package:guess_score/component/home_circle_button.dart';
import 'package:guess_score/component/root_provider.dart';
import 'package:guess_score/component/team_logo.dart';
import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/model/bet.dart';
import 'package:guess_score/model/custom_user.dart';
import 'package:guess_score/model/match.dart';
import 'package:guess_score/model/team.dart';
import 'package:guess_score/service/bet/abtract_bet_service.dart';
import 'package:guess_score/service/bet/default_bet_service.dart';
import 'package:guess_score/service/match/match_service.dart';
import 'package:guess_score/splash/process_indicator_page.dart';

class BetPage extends StatefulWidget {
  @override
  _BetPageState createState() => _BetPageState();
}

class _BetPageState extends State<BetPage> {
  MatchService _matchService;
  Map<int, Bet> betsMap = HashMap();
  Future matches;
  IBetService _betService;

  @override
  void initState() {
    _matchService = MatchService();
    _betService = DefaultBetService();
    matches =
        _matchService.findByInCompetitionScheduledMatches(Constants.LEAGUES);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: matches,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  itemCount: snapshot.data.count,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: matchRow(snapshot.data.matchList[index]),
                    );
                  },
                );
              } else {
                return CircularProgressIndicatorPage();
              }
            },
          ),
        ),
        CreateButton(
            onTap: (){createBet(BlocProvider.of<AuthenticationBloc>(context).state.user);},
            bets: betsMap,
            estAmount: _betService.calculateEstAmount(betsMap))
      ],
    );
  }

  createBet(CustomUser user) {
    _betService.createBet(user, betsMap);
  }

  Widget matchRow(Match match) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //home team stat
            teamInfo(match.competitionId, match.homeTeam),
            space(),
            //bets
            betsInfo(match),
            space(),
            //away team stat
            teamInfo(match.competitionId, match.awayTeam)
          ],
        )
      ],
    );
  }

  Widget teamInfo(int league, Team team) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              TeamLogo(
                teamMap: RootProvider.of(context),
                leagueId: league,
                team: team,
              ),
              teamWord(league, team),
            ],
          ),
        ],
      ),
    );
  }

  Widget teamWord(int league, Team team) {
    return Text(
      RootProvider.of(context)[league][team.id].shortName,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14),
    );
  }

  Widget betsInfoRow(Match match) {
    Bet _bet = betsMap[match.id];
    return Row(
      children: [
        HomeCircleButton(() {
          changeBet(match, 1);
        }, _bet),
        Text(" : "),
        DrawCircleButton(() {
          changeBet(match, 0);
        }, _bet),
        Text(" : "),
        AwayCircleButton(() {
          changeBet(match, 2);
        }, _bet)
      ],
    );
  }

  Widget betsInfo(Match match) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [betsInfoRow(match)],
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
          child: RootProvider.of(context)[competitionId][team.id].logo,
        ),
      ],
    );
  }

  void changeBet(Match match, int guess) {
    Map newBets = new Map<int, Bet>.from(betsMap);
    //tahmini kaldırmak istiyorsa
    if (newBets.containsKey(match.id) && newBets[match.id].bet == guess) {
      newBets.remove(match.id);
    }
    //tahmin girişi veya değiştirmek istiyorsa
    else {
      Bet _bet = Bet(match: match, bet: guess);
      if (newBets.containsKey(match.id))
        newBets.update(match.id, (value) => _bet);
      else
        newBets.putIfAbsent(match.id, () => _bet);
    }
    setState(() {
      betsMap = newBets;
    });
  }

  Widget space() {
    return SizedBox(
      width: 10,
    );
  }
}
