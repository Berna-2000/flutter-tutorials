import 'package:flutter/material.dart';
import '../signin.dart';
import '../signup.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({ Key? key }) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return Signin(toggleView: toggleView);
    }else{
      return SignupPage(toggleView: toggleView);
    }
  }
}

