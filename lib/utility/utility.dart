import 'package:guess_score/enum/winner_enum.dart';
import 'package:intl/intl.dart';

class Utility{
  static String  dateToStringWithRequiredFormat(DateTime dateTime){
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
  static String getValue(final int value){
    return value == null ? "0" : value.toString();
  }
  //Burayı yeniden düzenle
  static int convertResultToNumber(String result) {
    int numberResult;
    if (result == WinnerEnum.DRAW.getEnumValue()) {
      numberResult = 0;
    } else if (result == WinnerEnum.HOME_TEAM.getEnumValue()) {
      numberResult = 1;
    } else if (result == WinnerEnum.AWAY_TEAM.getEnumValue()) {
      numberResult = 2;
    } else {
      //result = null henüz başlamadı demektir.
      numberResult = null;
    }
    return numberResult;
  }
}