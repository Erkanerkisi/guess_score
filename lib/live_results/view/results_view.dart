import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/component/match_row.dart';
import 'package:guess_score/component/root_provider.dart';
import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/live_results/cubit/live_results_cubit.dart';
import 'package:guess_score/live_results/cubit/live_results_state.dart';
import 'package:guess_score/model/team.dart';

class ResultsView extends StatefulWidget {
  @override
  _ResultsViewState createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveResultsCubit, LiveResultsState>(
        builder: (context, state) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: state.fController,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: Constants.CALENDAR_NOW,
                              firstDate: Constants.CALENDAR_FIRST,
                              lastDate: Constants.CALENDAR_LAST)
                          .then((value) {
                        if (value != null) {
                          context.read<LiveResultsCubit>().setFirstDate(value);
                        }
                      });
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'İlk Tarih'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: state.sController,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: Constants.CALENDAR_NOW,
                              firstDate: Constants.CALENDAR_FIRST,
                              lastDate: Constants.CALENDAR_LAST)
                          .then((value) {
                        if (value != null) {
                          context.read<LiveResultsCubit>().setLastDate(value);
                        }
                      });
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Son Tarih'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text("Filter"),
                      onPressed: () {
                        context.read<LiveResultsCubit>().setMatches();
                        setState(() {});
                      },
                    )),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: state.matches,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return ListView.builder(
                    itemCount: snapshot.data.count,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.all(15.0),
                          child: MatchRow(
                            match: snapshot.data.matchList[index],
                            teamMap: RootProvider.of(context),
                            index : index
                          ));
                    },
                  );
                else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      );
    });
  }
}
