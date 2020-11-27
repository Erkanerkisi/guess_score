import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_score/model/bet.dart';
import 'package:guess_score/model/custom_user.dart';
import 'package:guess_score/model/mybet.dart';
import 'package:guess_score/repository/bet_repository.dart';

abstract class IBetService {
  BetRepository _betRepository = BetRepository();

  int calculateEstAmount(Map bet);

  createBet(CustomUser user, Map<int, Bet> bet) {
    final List content = List();
    bet.forEach((key, value) {
      Map map = HashMap();
      map.putIfAbsent("matchid", () => key);
      map.putIfAbsent("guess", () => value.bet);
      content.add(map);
    });
    _betRepository.createBet(user, calculateEstAmount(bet), content);
    print("hop");
  }

  List<MyBet> getMyBetList(QuerySnapshot qs) {

    List<MyBet> list = List();
    for (int index = 0; index < qs.docs.length; index++) {
      MyBet mybet = MyBet();
      mybet.betId = qs.docs[index].id;
      mybet.status = qs.docs[index]["status"];
      mybet.uid = qs.docs[index]["uid"];
      mybet.estAmount = qs.docs[index]["estAmount"];
      mybet.cost = qs.docs[index]["cost"];
      mybet.content = List();
      for (int index1 = 0; index1 < qs.docs[index]["content"].length; index1++) {
        Content c = Content();
        c.matchid = qs.docs[index]["content"][index1]["matchid"];
        c.guess =qs.docs[index]["content"][index1]["guess"];
        mybet.content.add(c);
      }
      list.add(mybet);
    }
    return list;
  }
}


