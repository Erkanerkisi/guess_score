import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/auth/bloc/auth_bloc.dart';
import 'package:guess_score/auth/bloc/auth_state.dart';
import 'package:guess_score/enum/status_enum.dart';
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
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 40,
                  columns: [
                    DataColumn(
                      label: Text(
                        'No',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Estimated points',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Cost points',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Status',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    )
                  ],
                  rows: createDataRows(list),
                ),
              );
            } else {
              return CircularProgressIndicatorPage();
            }
          },
        );
      },
    );
  }

  List<DataRow> createDataRows(List<MyBet> list) {
    var index = 1;
    List<DataRow> rows = List();
    list.forEach((element) {
      DataRow dataRow = DataRow(cells: List<DataCell>());
      dataRow.cells.add(DataCell(Center(child: Text(index.toString()))));
      dataRow.cells
          .add(DataCell(Center(child: Text(element.estAmount.toString()))));
      dataRow.cells.add(DataCell(Center(child: Text(element.cost.toString()))));
      dataRow.cells.add(DataCell(Center(
          child: element.status == Status.Waiting.getEnumValue()
              ? Icon(
                  Icons.timer,
                  color: Colors.blue,
                )
              : element.status == Status.Won.getEnumValue()
                  ? Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.clear,
                      color: Colors.red,
                    ))));
      rows.add(dataRow);
      index++;
    });
    return rows;
  }
}
