import 'package:guess_score/model/match.dart';
import 'package:guess_score/model/matches.dart';
import 'package:guess_score/service/match/abstract_match_service.dart';
import 'package:guess_score/service/match/api_match_service.dart';
import 'package:guess_score/service/match/firebase_match_service.dart';

class MatchService implements IMatchService {
  FirebaseMatchService _firebaseMatchService;
  ApiMatchService _apiMatchService;

  MatchService() {
    _firebaseMatchService = FirebaseMatchService();
    _apiMatchService = ApiMatchService();
  }

  @override
  Future<Matches> findByCompetitionAndFromDateAndToDateAndStatus(
      int competition,
      DateTime fromDate,
      DateTime toDate,
      String status) async {
    return await _apiMatchService
        .findByCompetitionAndFromDateAndToDateAndStatus(
            competition, fromDate, toDate, status);
  }

  @override
  Future<Matches> findByInCompetitionAndFromDateAndToDate(
      List competitions, DateTime fromDate, DateTime toDate) async {
    Matches matches =
        await _apiMatchService.findByInCompetitionAndFromDateAndToDate(
            competitions, fromDate, toDate);
    if (matches.count > 0) {
      List<Match> list = matches.matchList
          .where((element) => element.status == "FINISHED")
          .toList();
      _firebaseMatchService.chechFirebaseExistsOtherwiseAdd(list);
    }
    return matches;
  }

  @override
  Future<Matches> findByInCompetitionToday(List competitions) async {
    return await _apiMatchService.findByInCompetitionToday(competitions);
  }

  @override
  Future<Matches> findByInCompetitionScheduledMatches(List competitions) async {
    return await _apiMatchService
        .findByInCompetitionScheduledMatches(competitions);
  }

  @override
  Future<List<Match>> findByInMatchId(List<int> matchIdList) async {
    List<Match> result = List();
    List<Match> list =
        await _firebaseMatchService.findMatchFromFirebase(matchIdList);
    print("firebase count : " + list.length.toString());
    if (list.isNotEmpty) result.addAll(list);
    List<int> nonExistedMatchList = matchIdList
        .where((element) => list.where((ele) => ele.id == element).length == 0)
        .toList();
    print(
        "apiye gidecek match count : " + nonExistedMatchList.length.toString());
    List<Match> list1 =
        await _apiMatchService.findByInMatchId(nonExistedMatchList);
    print("api count : " + list1.length.toString());
    if (list1.isNotEmpty) result.addAll(list1);
    // Yok ise apiden çek
    // Bitenleri de db ye ekle.
    return result;
  }

  @override
  Future<Match> findByMatchId(int matchId) async {
    return await _apiMatchService.findByMatchId(matchId);
  }
}
