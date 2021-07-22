import 'dart:async';
import 'package:flutter/material.dart';
import '../partials/sizeconfig.dart';
import '../common/packages.dart';


class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  
  Timer? timer;
  // User user;
  final _auth = FirebaseAuth.instance;
  bool status = false;

  @override
  void initState(){
    // user = _auth.currentUser;
    // user.sendEmailVerification();
    // timer = Timer.periodic(Duration(seconds: 3), (timer) { 
    //  checkEmailVerified();
    // });
    super.initState();
  }

  @override
  // void dispose(){
  //   timer.cancel();
  //   super.dispose();
  // }

  Widget _buildVerificationMessage(){
    return Center(
      child:Text(
        // "A verification e-mail has been sent to ${user.email}",
        "A verification e-mail has been sent to someone@email.com",
        style: TextStyle(
          fontSize: 2 * SizeConfig.textMultiplier,
          fontFamily: "Montserrat",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffafafa),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        height: SizeConfig.screenHeight,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildVerificationMessage(),
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              // SpinKitChasingDots(color: Colors.tealAccent[200]),
            ],
          ),
        ),
      ),
    );
  }

  // Future <void> checkEmailVerified() async {
  //   user = _auth.currentUser;
  //   await user.reload();
  //   if(user.emailVerified){
  //     setState(() {
  //       timer.cancel();
  //     });
  //     SharedPreferences usernamePreferences = await SharedPreferences.getInstance();
  //     usernamePreferences.setString('currentUser', user.email);
  //     status = true;
  //     Navigator.of(context)
  //       .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper(status: status)));
  //   }
  // }
}

