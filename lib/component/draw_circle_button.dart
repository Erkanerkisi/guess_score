import 'package:flutter/material.dart';
import 'package:guess_score/component/circle_button.dart';
import 'package:guess_score/model/bet.dart';

class DrawCircleButton extends CircleButton {
  DrawCircleButton(GestureTapCallback onTap, Bet bet)
      : super(onTap: onTap, bet: bet);

  @override
  Color getColor() {
    return bet != null && bet.bet == 0 ? Colors.blue : Colors.grey;
  }

  @override
  Text getText() {
    return Text("2");
  }
}