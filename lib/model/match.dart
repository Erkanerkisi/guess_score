import 'package:guess_score/model/team.dart';

class Match{
  int id;
  Team homeTeam;
  Team awayTeam;
  String status;
  String winner;

  Match({this.id, this.homeTeam, this.awayTeam, this.status, this.winner});

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      homeTeam: Team.fromJson(json['homeTeam']),
      awayTeam: Team.fromJson(json['awayTeam']),
      status: json['status'],
      winner: json['score.winner'],
    );
  }
}

