import 'dart:convert';

import 'package:guess_score/api/api_client.dart';
import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/extensions/extensions.dart';
import 'package:guess_score/model/matches.dart';
import 'file:///C:/erkan/projects/guess_score/lib/service/match/abstract_match_service.dart';

class MatchService implements IMatchService{
  ApiClient _apiClient;

  MatchService() {
    _apiClient = ApiClient();
  }

  @override
  Future<Matches> findByCompetitionAndFromDateAndToDateAndStatus (int competition, DateTime fromDate, DateTime toDate, String status) async {
    final response = await _apiClient.requestGet(
        Constants.BASE_URL + "competitions/" + competition.toString() + "/matches?dateFrom=" + fromDate.toStringWithMyWay() +
            "&&dateTo=" + toDate.toStringWithMyWay() +"&&status="+ status +"",
        Constants.API_HEADERS);
    final json = jsonDecode(response.body);
    return Matches.fromJson(json);
  }

  @override
  Future<Matches> findByInCompetitionAndFromDateAndToDate(List competitions, DateTime fromDate, DateTime toDate) async{
    // TODO: implement findByInCompetitionAndFromDateAndToDate
    final response = await _apiClient.requestGet(
        Constants.BASE_URL + "matches?competitions="+ competitions.join(', ') +"&&dateFrom=" + fromDate.toStringWithMyWay() +
            "&&dateTo=" + toDate.toStringWithMyWay() +"",
        Constants.API_HEADERS);
    final json = jsonDecode(response.body);
    return Matches.fromJson(json);
  }

  @override
  Future<Matches> findByInCompetitionToday(List competitions) async{
    DateTime now = DateTime.now();
    // TODO: implement findByInCompetitionAndFromDateAndToDate
    final response = await _apiClient.requestGet(
        Constants.BASE_URL + "matches?competitions="+ competitions.join(', ') +"&&dateFrom=" + now.toStringWithMyWay() +
            "&&dateTo=" + now.toStringWithMyWay() +"",
        Constants.API_HEADERS);
    final json = jsonDecode(response.body);
    return Matches.fromJson(json);
  }
}
