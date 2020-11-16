import 'package:intl/intl.dart';

class Utility{
  static String  dateToStringWithRequiredFormat(DateTime dateTime){
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
  static String getValue(final int value){
    return value == null ? "0" : value.toString();
  }
}