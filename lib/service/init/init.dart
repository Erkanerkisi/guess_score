import 'dart:convert';

import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/model/team.dart';
import 'package:guess_score/service/team/team_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Init {
  static Map<int, Map<int,Team>> teamMap = Map();

  static init() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i in Constants.LEAGUES) {
      if (prefs.get(i.toString()) == null) {
        TeamService teamService = TeamService();
        List<Team> listTeam = await teamService.findByCompetition(i);
        prefs.setString(i.toString(), jsonEncode(listTeam));
        Map<int,Team> map = Map.fromIterable(listTeam, key: (t) => t.id, value: (e) => e);
        teamMap.putIfAbsent(i, () => map);
      } else {
        Map<int,Team> map2 = Map.fromIterable(jsonDecode(prefs.get(i.toString())), key: (t) => t["id"], value: (e) => Team.fromTeamJson(e));
        teamMap.putIfAbsent(i, () => map2);
      }
    }
  }
}
