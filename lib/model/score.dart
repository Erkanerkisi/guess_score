import 'package:guess_score/model/team.dart';

class Score{
  int homeTeamScore;
  int awayTeamScore;

  Score({this.homeTeamScore, this.awayTeamScore});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      homeTeamScore: json['homeTeam'],
      awayTeamScore: json['awayTeam'],
    );
  }
}