import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_score/model/bet.dart';
import 'package:guess_score/model/custom_user.dart';
import 'package:guess_score/service/bet/abtract_bet_service.dart';
import 'package:guess_score/service/bet/default_bet_service.dart';

class BetRepository {

  final CollectionReference betsCollection = FirebaseFirestore.instance.collection("bets");

  Future<QuerySnapshot> findBetsByUidAndStatus(CustomUser user,
      String status) async {
    return await betsCollection
        .where('uid', isEqualTo: user.uid)
        .where('status', isEqualTo: status)
        .get();
  }

  Future<QuerySnapshot> findBetsByUid(CustomUser user) async {
    return await betsCollection
        .where('uid', isEqualTo: user.uid)
        .get();
  }

  Future<void> createBet(CustomUser user, int estAmount, List content) async {
    return betsCollection.add({
      'status': "Waiting", // John Doe
      'uid': user.uid, // Stokes and Sons
      'estAmount': estAmount,
      'cost': 2,
      'content': content
    }).then((value) => print("Bet Added"))
        .catchError((error) => print("Failed to add bet: $error"));
  }
}