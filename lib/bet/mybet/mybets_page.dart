import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/auth/bloc/auth_bloc.dart';
import 'package:guess_score/auth/bloc/auth_state.dart';
import 'package:guess_score/bet/bet_detail/bet_detail_page.dart';
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      showCheckboxColumn: false,
                      //columnSpacing: 40,
                      columns: [
                        DataColumn(
                          label: Text(
                            'No',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Estimated',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),Text(
                                'points',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        DataColumn(
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cost',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),Text(
                                'points',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Status',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                      rows: createDataRows(list, context),
                    ),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicatorPage();
            }
          },
        );
      },
    );
  }

  List<DataRow> createDataRows(List<MyBet> list, BuildContext ctx) {
    var index = 1;
    List<DataRow> rows = List();
    list.forEach((element) {
      DataRow dataRow = DataRow(
        cells: List<DataCell>(),
        onSelectChanged: (bool selected){
          if(selected){
              Navigator.push(
                ctx,
                MaterialPageRoute(
                  builder: (context) => BetDetailPage(myBet : element),
                ),
              );
          }
        }
      );
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
