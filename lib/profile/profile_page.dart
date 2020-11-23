import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/auth/bloc/auth_bloc.dart';
import 'package:guess_score/repository/user_repository.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserRepository _userRepository =
        BlocProvider.of<AuthenticationBloc>(context).userRepository;
    return FutureBuilder(
      future: _userRepository.findCustomUserByUidOnFirestore(
          BlocProvider.of<AuthenticationBloc>(context).state.user),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 50),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  child: Image.network(snapshot.data.profileImage,
                      // width: 300,
                      height: 150,
                      fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    "Name: ${snapshot.data.displayName}",
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
                    "Email: ${snapshot.data.email}",
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
                    "Points: ${snapshot.data.point}",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
