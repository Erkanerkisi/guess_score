import 'package:equatable/equatable.dart';

class AuthenticationEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class DoAuthenticate extends AuthenticationEvent{
 final String userId;

  DoAuthenticate(this.userId);
}

class DoUnAuthenticate extends AuthenticationEvent{

}
class AppStarted extends AuthenticationEvent{

}