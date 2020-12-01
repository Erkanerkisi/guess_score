
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_score/enum/bet_status_enum.dart';
import 'package:guess_score/model/custom_user.dart';
import 'package:guess_score/model/mybet.dart';

class BetRepository {

  final CollectionReference betsCollection = FirebaseFirestore.instance.collection("bets");

  Future<QuerySnapshot> findBetsByUidAndStatus(CustomUser user,
      BetStatus status) async {
    return await betsCollection
        .where('uid', isEqualTo: user.uid)
        .where('status', isEqualTo: status.getEnumValue())
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
  updateStatus(String betId, BetStatus betStatus){
    return betsCollection
        .doc(betId)
        .update({'status': betStatus.getEnumValue()})
        .then((value) => print("bet status updated"))
        .catchError((error) => print("Failed to update bet status: $error"));
  }
}