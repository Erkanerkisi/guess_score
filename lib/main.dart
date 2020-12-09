import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/service/init/init.dart';
import 'package:guess_score/service/team/team_service.dart';
import 'component/root_provider.dart';
import 'file:///C:/erkan/projects/guess_score/lib/service/match/match_service.dart';

import 'app.dart';
import 'model/matches.dart';
import 'model/team.dart';

void main() async {
  /*MatchService matchService = MatchService();
  Matches matchList =
      await matchService.findByCompetitionAndFromDateAndToDateAndStatus(2021,
          DateTime.now(), DateTime.now().add(Duration(days: 8)), "SCHEDULED");
  print(matchList);
  TeamService teamService = TeamService();
  List<Team> teamList = await teamService.findByCompetition(2021);
  print(teamList);*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RootProvider(teamMap: await Init().init(), child: MyApp()));
  //print(Constants.LEAGUES.join(', '));
}
