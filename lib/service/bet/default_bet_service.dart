import 'package:guess_score/repository/bet_repository.dart';

import 'abtract_bet_service.dart';

class DefaultBetService extends IBetService {
  BetRepository betRepository;

  DefaultBetService({BetRepository betRepository}) :
        betRepository = betRepository == null ? BetRepository() : betRepository;

  @override
  int calculateEstAmount(Map bet) {
    var estAmount = 0;
    int index = 0;
    bet.forEach((key, value) {
      if (index == 0)
        estAmount = value.estPoint;
      else
        estAmount = estAmount * value.estPoint;
      index++;
    });
    return estAmount;
  }
}
