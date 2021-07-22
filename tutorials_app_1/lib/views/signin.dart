import 'package:tutorials_app_1/views/forgotPassword.dart';
import 'package:tutorials_app_1/wrapper.dart';
import '../common/packages.dart';
import '../services/backend_auth.dart';


class Signin extends StatefulWidget {
  final Function? toggleView;
  Signin({ this.toggleView });

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  String? emailAddress, password;
  IconData passwordIcon = Icons.remove_red_eye_sharp;
  bool isHidden = true;
  final logoSize = 150 * SizeConfig.imageSizeMultiplier;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Widget _buildLogoContainer(context){
    return Container(
      height: 0.5 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue[800],
      child: Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'),
          height:logoSize,
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
          onChanged: (input){
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
            if(input!.length < 1 ){
              return "This field is required";
            }else{
              return null;
            }
          },
          onSaved: (input){
            password = input.toString();
          },
          onChanged: (input){
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> 
            ForgotPasswordPage()));
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
        onPressed: () async{
          //some code here
          if(_formKey.currentState?.validate()==true){
            _formKey.currentState?.save();
            final AuthenticationMethods authMethods = AuthenticationMethods();
            dynamic result = await authMethods.signinWithEmailandPassword(emailAddress.toString(), password.toString());
            
            // if(result == null){
            //   showDialog(
            //     context: context,
            //     barrierDismissible: false,
            //     builder: (BuildContext context) {
            //       return AlertDialog(
            //         title: Text(
            //           "Error",
            //           style: TextStyle(
            //             fontWeight: FontWeight.w600,
            //             fontFamily: "Montserrat"
            //           )
            //         ),
            //         content: Text(
            //           "No account exists for the given e-mail address. Check your inputs.",
            //           style: TextStyle(
            //             fontSize: 2 * SizeConfig.textMultiplier,
            //             fontFamily: "Montserrat"
            //           )
            //         ),
            //         actions: [
            //           TextButton(
            //             child: Text(
            //               'OKAY',
            //               style: TextStyle(
            //                 color: Colors.red,
            //                 fontFamily: "Montserrat"
            //               )
            //             ),
            //             onPressed: () {
            //               // if(error == "verified"){
            //               //   // final user = authMethods.getCurrentUser();
            //               //   //sends another verification email
            //               //   Navigator.of(context)
            //               //         .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper(status: isVerified)));
            //               //   authMethods.verifyEmail();
            //               // }else if (error == "connected"){
            //               //   Navigator.of(context)
            //               //         .pushReplacement(MaterialPageRoute(builder: (context)=>MainPage()));
            //               // }
            //               Navigator.of(context).pop();
            //             },
            //           )
            //         ]
            //       );
            //     }
            //   );
            // }else{
            //   Navigator.of(context)
            //           .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper()));
            // }
          }else{
            
          }
          // if(_formKey.currentState?.validate() == true){
            // print("BOO");
            // _formKey.currentState!.save();
            // print("WOW");
            // final AuthenticationMethods authMethods = AuthenticationMethods();
            // dynamic result = await authMethods.signinWithEmailandPassword(emailAddress.toString(), password.toString());
            // print(result);
            // if(result == null){
            //   showDialog(
            //     context: context,
            //     barrierDismissible: false,
            //     builder: (BuildContext context) {
            //       return AlertDialog(
            //         title: Text(
            //           "Error",
            //           style: TextStyle(
            //             fontWeight: FontWeight.w600,
            //             fontFamily: "Montserrat"
            //           )
            //         ),
            //         content: Text(
            //           "No account exists for the given e-mail address. Check your inputs.",
            //           style: TextStyle(
            //             fontSize: 2 * SizeConfig.textMultiplier,
            //             fontFamily: "Montserrat"
            //           )
            //         ),
            //         actions: [
            //           TextButton(
            //             child: Text(
            //               'OKAY',
            //               style: TextStyle(
            //                 color: Colors.red,
            //                 fontFamily: "Montserrat"
            //               )
            //             ),
            //             onPressed: () {
            //               // if(error == "verified"){
            //               //   // final user = authMethods.getCurrentUser();
            //               //   //sends another verification email
            //               //   Navigator.of(context)
            //               //         .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper(status: isVerified)));
            //               //   authMethods.verifyEmail();
            //               // }else if (error == "connected"){
            //               //   Navigator.of(context)
            //               //         .pushReplacement(MaterialPageRoute(builder: (context)=>MainPage()));
            //               // }
            //               Navigator.of(context).pop();
            //             },
            //           )
            //         ]
            //       );
            //     }
            //   );
            // }else{
            //   Navigator.of(context)
            //           .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper()));
            // }
          // }else{
          //   print("BUANG");
          // }
        }
      )
    );
  }

  Widget _buildSignupRow(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(
              fontFamily: "Montserrat",
            ),
          ),
          InkWell(
            onTap: () {
              //some code to go to the registration page
              widget.toggleView!();
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                fontFamily: "Montserrat",
                color: Colors.cyan,
                fontWeight: FontWeight.w500,
              ),
            )
          )
        ],
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
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        _buildEmailForm(),//email
                        _buildPasswordForm(),//password
                        _buildForgotPassword(),//Forgot Password
                        _buildLoginButton(),//Login
                        _buildSignupRow()//Create an account
                        //Socials
                      ],
                    )
                  ),
                )
              )
            ],
          )
        )
      ),
    );
  }
}