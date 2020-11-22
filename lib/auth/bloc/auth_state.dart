import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable  {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState{
  final String userId;

  Authenticated(this.userId);

  @override
  List<Object> get props => [userId];
}

class UnAuthenticated extends AuthenticationState{

}

