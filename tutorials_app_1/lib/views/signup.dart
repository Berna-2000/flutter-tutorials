import '../common/packages.dart';
import '../partials/sizeconfig.dart';

class SignupPage extends StatefulWidget {
  final Function? toggleView;
  SignupPage({this.toggleView});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? username, emailAddress, password, confirmPassword;
  bool _isHidden = true, isLoading = false;
  IconData iconP = Icons.remove_red_eye_sharp;
  // User user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final logoSize = 150 * SizeConfig.imageSizeMultiplier;
  // final TextEditingController _passwordController = TextEditingController();

  // @override
  // void dispose(){
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  changeState(state){
    setState(() {
      isLoading = state;
    });
  }

  Widget _buildUsernameRow(){
    return SizedBox(
      height: 65,
      child: TextFormField(
        keyboardType: TextInputType.name,
        validator: (input){
          if(input.toString().isEmpty){
            return "This field is required";
          }else if (input.toString().isNotEmpty && input.toString().length < 6){
            return "Username should be 6-20 characters long";
          }else if(input.toString().length >20){
            return "Username should be at most 20 characters long";
          }else{
            return null;
          }
        },
        onSaved: (input) => username = input,
        onChanged: (value){
          setState(() {
            username = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blue[400],
          ),
          labelText: 'Username',
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

  Widget _buildEmailRow(){
    return SizedBox(
      height: 65,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (input) => EmailValidator.validate(input.toString())
            ? null
            : "Invalid E-mail Address",
        onSaved: (input) => emailAddress = input,
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

  Widget _buildPasswordRow(){
    return SizedBox(
      height: 65,
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (input){
          if(input.toString().length < 1 ){
            return "This field is required";
          }else if (input.toString().length >=1 && input.toString().length < 6){
            return "Password too short";
          }else{
            return null;
          }
        },
        onSaved: (input) => password = input,
        onChanged: (value){
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blue[400],
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isHidden = !_isHidden;
                if(iconP == Icons.visibility_off){
                  iconP = Icons.remove_red_eye_sharp;
                }else{
                  iconP = Icons.visibility_off;
                }
              });
            },
            icon: Icon(iconP),
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
        obscureText: _isHidden,
      )
    );
  }

  Widget _buildConfirmPasswordRow(){
    return SizedBox(
      height: 65,
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (input){
          if(input.toString().length < 1 ){
            return "This field is required";
          }else if (input != password){
            return "Passwords do not match!";
          }else{
            return null;
          }
        },
        onSaved: (input) => confirmPassword = input,
        onChanged: (value){
          setState(() {
            confirmPassword = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blue[400],
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isHidden = !_isHidden;
                if(iconP == Icons.visibility_off){
                  iconP = Icons.remove_red_eye_sharp;
                }else{
                  iconP = Icons.visibility_off;
                }
              });
            },
            icon: Icon(iconP),
          ),
          labelText: 'Confirm Password',
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
        obscureText: _isHidden,
      )
    );
  }

  Widget _buildSignupRow(BuildContext context){
    return Container(
      child: ElevatedButton(
        child: Text(
          "SIGN UP",
          style: TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green[200],
          padding: EdgeInsets.symmetric(horizontal: 160, vertical: 5),
        ),
        onPressed: () async{
          //some code here
        }
      )
    );
  }

  Widget _buildSigninRow(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
              fontFamily: "Montserrat",
            ),
          ),
          InkWell(
            onTap: () {
              widget.toggleView!();
              //some code to go to the sign in page
              // widget.toggleView();
            },
            child: Text(
              "Sign in",
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
                      _buildUsernameRow(),
                      _buildEmailRow(),//email
                      _buildPasswordRow(),//password
                      _buildConfirmPasswordRow(),
                      _buildSignupRow(context),
                      _buildSigninRow(),//Login
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
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Container(
    //             height: 0.25 * SizeConfig.screenHeight,
    //             decoration: BoxDecoration(
    //               color: Colors.cyan[200],
    //               image: DecorationImage(
    //                 colorFilter: new ColorFilter.mode(Colors.cyan[100].withOpacity(0.3), BlendMode.dstATop),
    //                 image: AssetImage('assets/images/chatbackground.jpg'),
    //                 fit: BoxFit.cover,
    //               ),
    //               borderRadius:BorderRadius.only(
    //                 bottomLeft: const Radius.circular(70),
    //                 bottomRight: const Radius.circular(70),
    //               )
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 20.0),
    //               child:  Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Image(
    //                         image: AssetImage('assets/images/chatapplogo.png'),
    //                         height: loginLogo,
    //                       ),
    //                     ],
    //                   ),
    //                   _buildHeaderWelcome(context),
    //                 ],
    //               ),
    //             ) 
    //           ),
    //           Container(
    //             height: 0.75 * SizeConfig.screenHeight,
    //             color: Colors.white,
    //             child: Form(
    //               key: _formKey,
    //               child: Padding(
    //                 padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
    //                 child: Column(
    //                   children: [
    //                     _buildUsernameRow(),
    //                     SizedBox(height: 5.0),
    //                     _buildEmailRow(),
    //                     SizedBox(height: 5.0),
    //                     _buildPasswordRow(),
    //                     SizedBox(height: 5.0),
    //                     _buildConfirmPasswordRow(),
    //                     SizedBox(height: 5.0),
    //                     _buildSignupRow(context),
    //                     _buildSigninRow(),
    //                     _buildOrRow(),
    //                     _buildSocialButtonRow(),
    //                   ],
    //                 )
    //               )
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );  
  }
}