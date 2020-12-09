import 'package:flutter/material.dart';
import 'package:guess_score/model/team.dart';

class RootProvider extends InheritedWidget {
  RootProvider({Key key, this.teamMap, Widget child}) : super(key: key, child: child);

  final Map<int, Map<int,Team>> teamMap;

  static Map of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<RootProvider>().teamMap;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
