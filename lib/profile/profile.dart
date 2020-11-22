import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 100),
          child: Icon(Icons.person_rounded,size: 100,),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
                "Name: Erkan",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
                "Surname: Erkisi",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
                "Points: 100",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        )
      ],
    );
  }
}
