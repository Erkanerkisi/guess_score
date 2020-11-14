import 'package:intl/intl.dart';

class Utility{
  String dateToStringWithRequiredFormat(DateTime dateTime){
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}