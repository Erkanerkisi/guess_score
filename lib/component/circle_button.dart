import 'package:flutter/material.dart';
import 'package:guess_score/model/bet.dart';

abstract class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final Bet bet;

  const CircleButton({Key key, this.onTap, this.bet}) : super(key: key);

  Color getColor();

  Text getText();

  @override
  Widget build(BuildContext context) {
    double size = 35.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: getColor(),
          shape: BoxShape.circle,
        ),
        child: Center(child: getText()),
      ),
    );
  }
}