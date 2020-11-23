import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_score/model/custom_user.dart';
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
        final CustomUser cuser = await userRepository.getCurrentUserAndConvertToCustomUser();
        yield Authenticated(cuser);
      }
    } else if (event is DoAuthenticate) {
      yield Authenticated(event.cuser);
    } else if (event is DoUnAuthenticate) {
      yield UnAuthenticated();
    }
  }
}
