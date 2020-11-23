import 'package:equatable/equatable.dart';
import 'package:guess_score/model/custom_user.dart';

class AuthenticationEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class DoAuthenticate extends AuthenticationEvent{
 final CustomUser cuser;

  DoAuthenticate(this.cuser);
}

class DoUnAuthenticate extends AuthenticationEvent{

}
class AppStarted extends AuthenticationEvent{

}