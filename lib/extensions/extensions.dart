import 'package:intl/intl.dart';

extension MyExtension on DateTime {
  String toStringWithMyWay() {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}