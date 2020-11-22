import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/repository/user_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({this.userRepository}) : super(UnAuthenticated());
  UserRepository userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final isSignedIn = await userRepository.isSignedIn();
      if (isSignedIn) {
        final User user = userRepository.getUser();
        yield Authenticated(user.uid);
      }
    } else if (event is DoAuthenticate) {
      yield Authenticated(event.userId);
    } else if (event is DoUnAuthenticate) {
      yield UnAuthenticated();
    }
  }
}
