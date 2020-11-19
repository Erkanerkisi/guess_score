import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/model/matches.dart';
import 'package:guess_score/service/match/match_service.dart';
import 'package:guess_score/utility/utility.dart';

import 'live_results_state.dart';

class LiveResultsCubit extends Cubit<LiveResultsState> {
  LiveResultsCubit(LiveResultsState initialState): super(initialState){
   initialState.matches = getMatches(initialState.firstDate, initialState.lastDate);
  }


  void setFirstDate(DateTime firstDate) {
    LiveResultsState liveResultsState = this.state;
    liveResultsState.firstDate = firstDate;
    String firstDateStr = Utility.dateToStringWithRequiredFormat(firstDate);
    liveResultsState.firstDateStr = firstDateStr;
    liveResultsState.fController.text = firstDateStr;
    //liveResultsState.matches = getMatches(firstDate, liveResultsState.lastDate);
    emit(liveResultsState);
  }
  void setLastDate(DateTime lastDate) {
    LiveResultsState liveResultsState = this.state;
    liveResultsState.lastDate = lastDate;
    String secondDateStr = Utility.dateToStringWithRequiredFormat(lastDate);
    liveResultsState.lastDateStr = secondDateStr;
    liveResultsState.sController.text = secondDateStr;
    //liveResultsState.matches = getMatches(liveResultsState.firstDate, lastDate);
    emit(liveResultsState);
  }
  void setMatches() {
    LiveResultsState liveResultsState = this.state;
    Future<Matches> futureVar = getMatches(liveResultsState.firstDate, liveResultsState.lastDate);
    liveResultsState.matches = futureVar;
    emit(liveResultsState);
  }
  Future getMatches(fDate, lDate) {
    final MatchService _matchService = MatchService();
    return _matchService.findByInCompetitionAndFromDateAndToDate(
        Constants.LEAGUES, fDate, lDate);
  }
}
