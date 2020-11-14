import 'package:guess_score/model/team.dart';

abstract class ITeamService{

  Future<List<Team>>  findByCompetition (int competition);

}