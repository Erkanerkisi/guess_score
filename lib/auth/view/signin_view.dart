import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guess_score/auth/bloc/auth_bloc.dart';
import 'package:guess_score/auth/bloc/auth_event.dart';
import 'package:guess_score/model/custom_user.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Sign in With Google"),
              onPressed: (){
                doAuth(context);
              },
            ),
          ],
        ),
      ),
    );
  }
  void doAuth(BuildContext ctx) async{
    UserCredential user = await _authenticationBloc.userRepository.signInWithGoogle();
    CustomUser cuser = await _authenticationBloc.userRepository.convertGoogleUsertoCustomUser(user.user);
    if(cuser != null && cuser.uid !=null ){
      _authenticationBloc.add(DoAuthenticate(cuser));
    }
  }
}
