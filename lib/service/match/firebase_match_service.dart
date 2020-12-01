import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_score/model/match.dart';
import 'package:guess_score/model/score.dart';
import 'package:guess_score/model/team.dart';
import 'package:guess_score/repository/match_repository.dart';


class FirebaseMatchService {

  MatchRepository _matchRepository;
  FirebaseMatchService(){
    _matchRepository = MatchRepository();
  }

  List<Match> getMatchListFromFirebase(QuerySnapshot qs) {
    List<Match> list = List();
    for (int index = 0; index < qs.docs.length; index++) {
      Match match = Match();
      match.id =int.parse(qs.docs[index].id);
      match.winner = qs.docs[index]["winner"];
      match.status = qs.docs[index]["status"];
      match.awayTeam = Team();
      match.awayTeam.id = qs.docs[index]["awayTeam"][0];
      match.awayTeam.name = qs.docs[index]["awayTeam"][1];

      match.homeTeam = Team();
      match.homeTeam.id = qs.docs[index]["homeTeam"][0];
      match.homeTeam.name = qs.docs[index]["homeTeam"][1];

      match.competitionId = qs.docs[index]["competitionId"];
      match.score = Score();
      match.score.homeTeamScore = qs.docs[index]["score"][0];
      match.score.awayTeamScore = qs.docs[index]["score"][1];

      list.add(match);
    }
    return list;
  }

  List<int> getMatchIdFromFirebase(QuerySnapshot qs) {
    List<int> list = List();
    for (int index = 0; index < qs.docs.length; index++) {
      int matchId = int.parse(qs.docs[index].id);
      list.add(matchId);
    }
    return list;
  }

  readAndCompareLists(List<Match> matchList, List<int> matchIdList) async {
    List<int> existedMatchList = await readTenRecord(matchIdList);
    List<Match> notExistedList = matchList
        .where((element) => !existedMatchList.contains(element.id))
        .toList();
    _matchRepository.addMatchList(notExistedList);
  }

  Future<List<int>> readTenRecord(List<int> matchIdList) async{
    return getMatchIdFromFirebase(await _matchRepository.findMatchList(matchIdList));
  }

  Future<List<Match>> readTenMatchRecord(List<int> matchIdList) async{
    return getMatchListFromFirebase(await _matchRepository.findMatchList(matchIdList));
  }

  chechFirebaseExistsOtherwiseAdd(List<Match> matchList) async {
    List<int> matchIdList = List();
    for (int i = 0; i < matchList.length; i++) {
      matchIdList.add(matchList[i].id);
      if ((matchIdList.length + 1) % 10 == 0 ||
          matchIdList.length > 0 && i + 1 == matchList.length) {
        //Firebaseden 10 luğu oku.
        await readAndCompareLists(matchList, matchIdList);
        matchIdList.clear();
      }
    }
  }
  Future<List<Match>> findMatchFromFirebase(List<int> list) async{
    List<Match> result = List();
    List<int> matchIdList = List();
    for (int i = 0; i < list.length; i++) {
      matchIdList.add(list[i]);
      if ((matchIdList.length + 1) % 10 == 0 ||
          matchIdList.length > 0 && i + 1 == list.length) {
        result.addAll(await readTenMatchRecord(matchIdList));
        matchIdList.clear();
      }
    }
    return result;
  }
}
