import 'dart:convert';

import 'package:guess_score/api/api_client.dart';
import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/extensions/extensions.dart';
import 'package:guess_score/model/matches.dart';
import 'package:guess_score/model/match.dart';
import 'package:guess_score/service/match/firebase_match_service.dart';

import 'abstract_match_service.dart';

class ApiMatchService {
  ApiClient _apiClient;
  FirebaseMatchService _firebaseMatchService;
  ApiMatchService() {
    _apiClient = ApiClient();
    _firebaseMatchService = FirebaseMatchService();
  }

  Future<Matches> findByCompetitionAndFromDateAndToDateAndStatus(
      int competition,
      DateTime fromDate,
      DateTime toDate,
      String status) async {
    final response = await _apiClient.requestGet(
        Constants.BASE_URL +
            "competitions/" +
            competition.toString() +
            "/matches?dateFrom=" +
            fromDate.toStringWithMyWay() +
            "&&dateTo=" +
            toDate.toStringWithMyWay() +
            "&&status=" +
            status +
            "",
        Constants.API_HEADERS);
    final json = jsonDecode(response.body);
    return Matches.fromJson(json);
  }

  Future<Matches> findByInCompetitionAndFromDateAndToDate(
      List competitions, DateTime fromDate, DateTime toDate) async {
    // TODO: implement findByInCompetitionAndFromDateAndToDate
    final response = await _apiClient.requestGet(
        Constants.BASE_URL +
            "matches?competitions=" +
            competitions.join(', ') +
            "&&dateFrom=" +
            fromDate.toStringWithMyWay() +
            "&&dateTo=" +
            toDate.toStringWithMyWay() +
            "",
        Constants.API_HEADERS);
    final json = jsonDecode(response.body);
    Matches matches = Matches.fromJson(json);
    return matches;
  }

  Future<Matches> findByInCompetitionToday(List competitions) async {
    DateTime now = DateTime.now();
    // TODO: implement findByInCompetitionAndFromDateAndToDate
    final response = await _apiClient.requestGet(
        Constants.BASE_URL +
            "matches?competitions=" +
            competitions.join(', ') +
            "&&dateFrom=" +
            now.toStringWithMyWay() +
            "&&dateTo=" +
            now.toStringWithMyWay() +
            "",
        Constants.API_HEADERS);
    final json = jsonDecode(response.body);
    return Matches.fromJson(json);
  }

  Future<Matches> findByInCompetitionScheduledMatches(List competitions) async {
    DateTime now = DateTime.now();
    // TODO: implement findByInCompetitionAndFromDateAndToDate
    DateTime from = DateTime.now();
    DateTime to = DateTime.now().add(Duration(days: 10));
    final response = await _apiClient.requestGet(
        Constants.BASE_URL +
            "matches?competitions=" +
            competitions.join(', ') +
            "&&dateFrom=" +
            from.toStringWithMyWay() +
            "&&dateTo=" +
            to.toStringWithMyWay() +
            "&&status=SCHEDULED",
        Constants.API_HEADERS);
    final json = jsonDecode(response.body);
    Matches matches = Matches.fromJson(json);
    return matches;
  }

  Future<List<Match>> findByInMatchId(List<int> matchIdList) async {
    List<Match> matchList = List();

   for(int matchId in matchIdList){
     await findByMatchId(matchId).then((value) => matchList.add(value));
   }
   return matchList;
  }

  Future<Match> findByMatchId(int matchId) async{
    // TODO: implement findByMatchId
    final response = await _apiClient.requestGet(Constants.BASE_URL + "matches/" + matchId.toString() + "", Constants.API_HEADERS);
    final json = jsonDecode(response.body);
    Match match = Match.fromJson(json["match"]);
    return match;
  }
}
