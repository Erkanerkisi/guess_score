import 'package:guess_score/model/matches.dart';

abstract class IMatchService{

  Future<Matches>  findByCompetitionAndFromDateAndToDateAndStatus (int competition, DateTime fromDate, DateTime toDate, String status);
  Future<Matches> findByInCompetitionAndFromDateAndToDate (List competitions, DateTime fromDate, DateTime toDate);
  Future<Matches> findByInCompetitionToday (List competitions);

}