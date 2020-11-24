import 'package:flutter/material.dart';
import 'package:guess_score/model/matches.dart';
import 'package:guess_score/utility/utility.dart';

abstract class LiveResultsState {
  DateTime firstDate;
  DateTime lastDate;
  String firstDateStr;
  String lastDateStr;
  TextEditingController fController;
  TextEditingController sController;
  Future<Matches> matches;

  LiveResultsState(
      {this.firstDate, this.lastDate, this.firstDateStr, this.lastDateStr, this.matches}) {
    fController = TextEditingController();
    sController = TextEditingController();
    fController.text = firstDateStr;
    sController.text = lastDateStr;
  }
}

class LiveResultsStateInitial extends LiveResultsState {
  LiveResultsStateInitial()
      : super(
            firstDate: DateTime.now(),
            lastDate: DateTime.now(),
            firstDateStr: Utility.dateToStringWithRequiredFormat(
                DateTime.now()),
            lastDateStr: Utility.dateToStringWithRequiredFormat(
                DateTime.now()));
}
