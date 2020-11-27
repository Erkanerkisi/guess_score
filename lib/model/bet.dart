import 'package:guess_score/model/match.dart';

class Bet {
  Match match;
  int bet;
  int estPoint;

  Bet({this.match, this.bet}) {
    estPoint = bet == 0 ? 3 : 2;
  }
}
