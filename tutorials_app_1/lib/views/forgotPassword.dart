import 'package:flutter/material.dart';
import 'package:tutorials_app_1/views/authenticate/authenticate.dart';
import '../services/backend_auth.dart';
import '../common/packages.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String emailAddress="";
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildEmailRow(){
    return SizedBox(
      height: 70,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (input) => EmailValidator.validate(input.toString())
            ? null
            : "Invalid E-mail Address",
        onSaved: (input) => emailAddress = input.toString(),
        onChanged: (value){
          emailAddress = value;
          setState(() {
            emailAddress = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.blue[400],
          ),
          labelText: 'E-mail Address',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          )
        ),
      )
    );
  }

  Widget _buildForgotPassword(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container (
          height: 6 * SizeConfig.heightMultiplier,
          width: 0.85 * MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () async {
              //sends the reset password email
              // Pop up notify that an email has already been sent to your email address
              //Send reset password email to your email address
              AuthenticationMethods authMethods = new AuthenticationMethods();
              if(_formKey.currentState?.validate()==true){
                _formKey.currentState?.save();
                print(emailAddress);
                await authMethods.resetPassword(emailAddress);
                setState(() {
                  isLoading = true;
                });
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Success',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat"
                        )
                      ),
                      content: Text(
                        "An email has been sent to " +emailAddress,
                        style: TextStyle(
                          fontSize: 2 * SizeConfig.textMultiplier,
                          fontFamily: "Montserrat"
                        )
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'OKAY',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: "Montserrat"
                            )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Authenticate()));
                          },
                        )
                      ]
                    );
                  }
                );
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xfff1976d2),
              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 5.0,
            ),
            child: Text(
              "Send Reset Password Email",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.0,
                fontSize: 2 * SizeConfig.textMultiplier,
              )
            ),
          )
        )
      ],
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff1976d2), 
        title: Text("ChatApp Tutorial Reset Password"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        height: SizeConfig.screenHeight,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildEmailRow(),
              SizedBox(height: 15.0),
              _buildForgotPassword()
            ],
          ),
        )
      ),
    );
  }
}