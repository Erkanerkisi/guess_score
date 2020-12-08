import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_score/enum/bet_status_enum.dart';
import 'package:guess_score/enum/match_status_enum.dart';
import 'package:guess_score/model/bet.dart';
import 'package:guess_score/model/custom_user.dart';
import 'package:guess_score/model/mybet.dart';
import 'package:guess_score/model/match.dart';

import 'package:guess_score/repository/bet_repository.dart';
import 'package:guess_score/repository/user_repository.dart';
import 'package:guess_score/service/match/match_service.dart';
import 'package:guess_score/utility/utility.dart';

abstract class IBetService {
  BetRepository _betRepository = BetRepository();
  UserRepository _userRepository = UserRepository();
  MatchService _matchService = MatchService();

  int calculateEstAmount(Map bet);

  Future<QuerySnapshot> findBetsByUid(CustomUser user) async {
    await checkBetResults(user);
    return _betRepository.findBetsByUid(user);
  }

  createBet(CustomUser user, Map<int, Bet> bet) {
    final List content = List();
    bet.forEach((key, value) {
      Map map = HashMap();
      map.putIfAbsent("matchid", () => key);
      map.putIfAbsent("guess", () => value.bet);
      content.add(map);
    });
    //Cost standart 2, değiştirmek istersek burdan parametrik yapalım.

    _betRepository.createBet(user, calculateEstAmount(bet), content);
    _userRepository.updateUserPoint(user, -2);
  }

  List<MyBet> getMyBetList(QuerySnapshot qs) {
    List<MyBet> list = List();
    for (int index = 0; index < qs.docs.length; index++) {
      MyBet myBet = MyBet(
          uid: qs.docs[index]["uid"],
          betId: qs.docs[index].id,
          cost: qs.docs[index]["cost"],
          content: List(),
          status: qs.docs[index]["status"],
          estAmount: qs.docs[index]["estAmount"]);

      for (int index1 = 0;
          index1 < qs.docs[index]["content"].length;
          index1++) {
        Content c = Content(
            matchid: qs.docs[index]["content"][index1]["matchid"],
            guess: qs.docs[index]["content"][index1]["guess"]);
        myBet.content.add(c);
      }
      list.add(myBet);
    }
    return list;
  }

  void checkBetResults(CustomUser user) async {
    List<MyBet> list = getMyBetList(
        await _betRepository.findBetsByUidAndStatus(user, BetStatus.Waiting));
    for (MyBet myBet in list) {
      bool lost = false;
      bool waiting = false;
      //Content içerisindeki matchid leri listeye çevir.
      List<int> matchIdList = myBet.content.map((e) => e.matchid).toList();
      //Content içerisindeki matchid leri bul.
      List<Match> matchList = await _matchService.findByInMatchId(matchIdList);
      for (Content content in myBet.content) {
        Match match =
            matchList.firstWhere((element) => element.id == content.matchid);
        if (match.status == MatchStatus.FINISHED.getEnumValue() &&
            Utility.convertResultToNumber(match.winner) != content.guess) {
          updateStatus(myBet.betId, BetStatus.Lost);
          lost = true;
          return;
        } else if (match.status != MatchStatus.FINISHED.getEnumValue()) {
          waiting = true;
        }
      }
      if (!lost && !waiting) {
        updateStatus(myBet.betId, BetStatus.Won);
        updatePoint(user, myBet.estAmount);
      }
      //otherwise still waiting.
    }
  }

  updateStatus(betid, status) {
    _betRepository.updateStatus(betid, status);
  }

  updatePoint(user, point) {
    _userRepository.updateUserPoint(user, point);
  }
}
