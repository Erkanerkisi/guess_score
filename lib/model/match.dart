import 'package:guess_score/model/score.dart';
import 'package:guess_score/model/team.dart';

class Match{
  int id;
  Team homeTeam;
  Team awayTeam;
  String status;
  String winner;
  Score score;
  int competitionId;

  Match({this.id, this.homeTeam, this.awayTeam, this.status, this.winner,this.score, this.competitionId});

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      homeTeam: Team.fromJson(json['homeTeam']),
      awayTeam: Team.fromJson(json['awayTeam']),
      status: json['status'],
      winner: json['score']['winner'],
      score: Score.fromJson(json['score']['fullTime']),
      competitionId: json['competition']['id']
    );
  }
}

