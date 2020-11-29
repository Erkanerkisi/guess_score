import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_score/model/match.dart';

final CollectionReference matchesCollection =
FirebaseFirestore.instance.collection("matches");

class MatchRepository {

  Future<void> addMatch(Match match) {
    List awayTeam = List();
    awayTeam.add(match.awayTeam.id);
    awayTeam.add(match.awayTeam.name);
    List homeTeam = List();
    homeTeam.add(match.homeTeam.id);
    homeTeam.add(match.homeTeam.name);
    List score = List();
    score.add(match.score.homeTeamScore);
    score.add(match.score.awayTeamScore);
    matchesCollection
        .doc(match.id.toString())
        .set({
      'status': match.status,
      'winner': match.winner,
      'competitionId': match.competitionId,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'score': score
    })
        .then((value) => print("Match Added"))
        .catchError((error) => print("Failed to add match: $error"));
  }

  addMatchList(List<Match> matchList) {
    //Firebase e ekle
    matchList.forEach((element) {
      addMatch(element);
    });
  }

  Future<QuerySnapshot> findMatchList(List<int> matchList) async {
    List<String> listOfStringId = matchList.map((e) => e.toString()).toList();
    return await matchesCollection
        .where(FieldPath.documentId, whereIn: listOfStringId)
        .get();
    //db.collection("projects").where("status", "in", ["public", "unlisted"]);
  }
}