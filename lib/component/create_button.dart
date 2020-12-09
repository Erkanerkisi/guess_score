
import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final Function onTap;
  final Map bets;
  final int estAmount;

  CreateButton({this.onTap, this.bets, this.estAmount});

  Function validateButton() {
    if (bets.isNotEmpty && bets.length > 3)
      return () {
        onTap();
      };
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Create"),
              Text("Min Match : " + bets.length.toString() + " / 4"),
              Text("Est Amount: " + estAmount.toString())
            ],
          ),
          color: Colors.blue,
          onPressed: validateButton(),
        ));
  }
}
