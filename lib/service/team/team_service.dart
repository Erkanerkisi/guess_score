import 'dart:convert';

import 'package:guess_score/api/api_client.dart';
import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/model/team.dart';
import 'package:guess_score/service/team/abstract_team_service.dart';


class TeamService implements ITeamService{
  ApiClient _apiClient;

  TeamService() {
    _apiClient = ApiClient();
  }

  @override
  Future<List<Team>> findByCompetition (int competition) async {
    final response = await _apiClient.requestGet(
        Constants.BASE_URL + "competitions/" + competition.toString() + "/teams",
        Constants.API_HEADERS);
    final json = jsonDecode(response.body);
    List<Team> listTeam = List<Team>.from(json["teams"].map((team) => Team.fromTeamJson(team)));
    return listTeam;
  }
}
