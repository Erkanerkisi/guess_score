import 'package:guess_score/model/matches.dart';
import 'package:guess_score/model/match.dart';

abstract class IMatchService{

  Future<Matches>  findByCompetitionAndFromDateAndToDateAndStatus (int competition, DateTime fromDate, DateTime toDate, String status);
  Future<Matches> findByInCompetitionAndFromDateAndToDate (List competitions, DateTime fromDate, DateTime toDate);
  Future<Matches> findByInCompetitionToday (List competitions);
  Future<Matches> findByInCompetitionScheduledMatches (List competitions);
  Future<Matches> findByInMatchId (List<int> matchIdList);
  Future<Match> findByMatchId (int matchId);
}