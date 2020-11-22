import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/auth/bloc/auth_bloc.dart';
import 'package:guess_score/repository/user_repository.dart';
import 'auth/bloc/auth_event.dart';
import 'auth/bloc/auth_state.dart';
import 'auth/view/signin_view.dart';
import 'route/home_page_router.dart';
import 'live_results/view/results_page.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationBloc _authenticationBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _authenticationBloc,
        child: MaterialApp(
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                cubit: _authenticationBloc,
                builder: (context, state) {
                  if (state is Authenticated) {
                    return HomePageRouter();
                  } else if (state is UnAuthenticated) {
                    return SignInView();
                  } else
                    return SignInView();
                })));
  }

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: UserRepository());
    _authenticationBloc.add(AppStarted());
  }
}
