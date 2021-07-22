import 'package:flutter/material.dart';
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