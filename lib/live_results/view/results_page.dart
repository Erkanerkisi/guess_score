import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_score/constants/constants.dart';
import 'package:guess_score/live_results/cubit/live_results_cubit.dart';
import 'package:guess_score/live_results/cubit/live_results_state.dart';
import 'package:guess_score/live_results/view/results_view.dart';
import 'package:guess_score/model/match.dart';
import 'package:guess_score/model/team.dart';
import 'package:guess_score/service/init/init.dart';
import 'package:guess_score/service/match/match_service.dart';
import 'package:guess_score/utility/utility.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LiveResultsCubit(LiveResultsStateInitial()),
        child: ResultsView());
  }
}
