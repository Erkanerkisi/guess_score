import 'package:guess_score/model/match.dart';

class Matches{
  int count;
  List<Match> matchList;

  Matches({this.count, this.matchList});

  factory Matches.fromJson(Map<String, dynamic> json) {
    int count = json['count'];
    return Matches(
        count: count,
        matchList: List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
    );
  }
}