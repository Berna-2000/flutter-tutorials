import'package:flutter/material.dart';
import '../partials/sizeconfig.dart';
import 'package:email_validator/email_validator.dart';


class Signin extends StatefulWidget {
  const Signin({ Key? key }) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  String? emailAddress, password;
  IconData passwordIcon = Icons.remove_red_eye_sharp;
  bool isHidden = true;

  Widget _buildLogoContainer(context){
    return Container(
      height: 0.5 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue[800],
      child: Center(
        child: Text(
          "LOGO",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          )
        )
      )
    );
  }

  Widget _buildEmailForm(){
    return SizedBox(
      height: 65,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (input) => EmailValidator.validate(input.toString())
                ? null
                : "Invalid E-mail Address",
          onSaved: (input){
            emailAddress = input.toString();
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
        ),
      )
    );
  }

  Widget _buildPasswordForm(){
    return SizedBox(
      height: 65,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: isHidden,
          validator: (input){
            if(input.toString().length < 1 ){
              return "This field is required";
            }else{
              return null;
            }
          },
          onSaved: (input){
            password = input.toString();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.blue[400],
            ),
            suffixIcon: IconButton(
              onPressed: () {
                //some code here
                setState(() {
                  isHidden = !isHidden;
                  if(passwordIcon == Icons.remove_red_eye_sharp){
                  passwordIcon = Icons.visibility_off;
                  }else{
                    passwordIcon = Icons.remove_red_eye_sharp;
                  }
                });
              },
              icon: Icon(passwordIcon),
              color: Colors.grey[400],
            ),
            labelText: 'Password',
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
        ),
      )
    );
  }

  Widget _buildForgotPassword(){
    return Container(
      padding: EdgeInsets.zero,
      alignment: Alignment.topRight,
      child: TextButton(
        child: Text(
          "Forgot Password",
          style: TextStyle(
            color: Colors.cyan,
          ),
        ),
        onPressed: (){
          //some code here
        },
      )
    );
  }

  Widget _buildLoginButton(){
    return Container(
      child: ElevatedButton(
        // color: Color(0xfff1976d2), 
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(30.0),
        // ),
        child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green[200],
          padding: EdgeInsets.symmetric(horizontal: 175, vertical: 5),
        ),
        onPressed: (){
          //some code here
        }
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLogoContainer(context),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      _buildEmailForm(),//email
                      _buildPasswordForm(),//password
                      _buildForgotPassword(),//Forgot Password
                      _buildLoginButton(),//Login
                      //Create an account
                      //Socials
                    ],
                  )
                )
              )
            ],
          )
        )
      ),
    );
  }
}