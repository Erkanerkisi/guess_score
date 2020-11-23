import 'package:equatable/equatable.dart';
import 'package:guess_score/model/custom_user.dart';

class AuthenticationState extends Equatable  {
  CustomUser user;

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState{

  Authenticated(CustomUser usr){
    user = usr;
  }
  @override
  List<Object> get props => [user];
}

class UnAuthenticated extends AuthenticationState{
  UnAuthenticated(){
    user = null;
  }
}

