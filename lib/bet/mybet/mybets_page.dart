import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/auth/bloc/auth_bloc.dart';
import 'package:guess_score/auth/bloc/auth_state.dart';
import 'package:guess_score/model/mybet.dart';
import 'package:guess_score/repository/bet_repository.dart';
import 'package:guess_score/service/bet/abtract_bet_service.dart';
import 'package:guess_score/service/bet/default_bet_service.dart';
import 'package:guess_score/splash/process_indicator_page.dart';

class MyBetsPage extends StatelessWidget {

  final IBetService _betService = DefaultBetService();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return FutureBuilder(
          future: BetRepository().findBetsByUid(state.user),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MyBet> list = _betService.getMyBetList(snapshot.data);
              return ListView.builder(itemCount:list.length, itemBuilder: (context, index) {
                return ListTile(title: Text("Bet : " + list[index].estAmount.toString()),leading: Icon(Icons.ac_unit),trailing: Text(list[index].status),);
              },);

            } else {
              return CircularProgressIndicatorPage();
            }
          },
        );
      },
    );
  }
}
