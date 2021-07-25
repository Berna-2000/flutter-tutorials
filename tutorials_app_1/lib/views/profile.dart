// import 'package:chatapp_ferolin/common/packages.dart';
// import 'package:chatapp_ferolin/partials/loadingPage.dart';
// import 'package:chatapp_ferolin/services/authentication.dart';
// import 'package:chatapp_ferolin/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:tutorials_app_1/views/authenticate/authenticate.dart';
import '../partials/sizeconfig.dart';
import '../common/packages.dart';
import '../services/backend_auth.dart';
import '../partials/loading.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Default User", 
         emailAddress = "defaultuser@email.com", 
         displayPhoto = "";
  bool isLoading = true;
  User? currentUser;
  final AuthenticationMethods authMethods = new AuthenticationMethods();

  @override
  void initState(){
    _getCurrentUser();
    super.initState();
  }

  _getCurrentUser() async {
    await authMethods.getCurrentUser().then((result){
      currentUser = result;
      print(currentUser);
      setState(() {
        isLoading = false;
      });
    });
  }



  Widget _buildProfilePhoto(displayPhoto){
    return Container(
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Color(0xfff1976d2),
        child: CircleAvatar(
          radius: 95,
          backgroundColor: Color(0xfff60affe),
          child: CircleAvatar(
            radius: 90.0,
            backgroundImage: NetworkImage(displayPhoto)
          )
        )
      )
    );
  }

  Widget _buildName(String name){
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        name,
        style: TextStyle(
          color: Color(0xfffa0a0a0),
          fontWeight: FontWeight.w900,
          fontSize: 4 * SizeConfig.textMultiplier,
        )
      ),
    );
  }

  Widget _buildEmailAddress(String emailAddress){
    return Container(
      child: Text(
        emailAddress,
        style: TextStyle(
          color: Color(0xfffa0a0a0),
          fontWeight: FontWeight.bold,
          fontSize: 2.5 * SizeConfig.textMultiplier,
        )
      ),
    );
  }

  Widget _buildSignout(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container (
          margin: EdgeInsets.symmetric(vertical:15.0),
          height: 6 * SizeConfig.heightMultiplier,
          width: 0.85 * MediaQuery.of(context).size.width,
          child: ElevatedButton(
            child: Text(
              "SIGN OUT",
              style: TextStyle(color: Colors.black)
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xffff1f1f1),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              //some code to sign out 
              final AuthenticationMethods authmethods = new AuthenticationMethods();
              // bool isVerified;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Sign Out?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat"
                      )
                    ),
                    content: Text(
                      'Are you sure you want to sign out?',
                      style: TextStyle(
                        fontSize: 2 * SizeConfig.textMultiplier,
                        fontFamily: "Montserrat"
                      )
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat"
                          )
                        ),
                        onPressed: () {
                          setState(() {
                            // isVerified = false;
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                          // Navigator.of(context)
                          //   .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper(status: isVerified)));
                        },
                      ),
                      TextButton(
                        child: Text(
                          'YES',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Montserrat"
                          )
                        ),
                        onPressed: () async {
                          //code to actually sign out
                          await authmethods.signOut();
                          Navigator.of(context).pop();
                          Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (context)=> Authenticate()));
                        },
                      ),
                    ]
                  );
                }
              );
            }
          )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    // name = user.displayName;
    // emailAddress = user.email;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading ? Loading() : SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            height: SizeConfig.screenHeight*0.85,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfilePhoto(currentUser?.photoURL),
                _buildName((currentUser?.displayName).toString()),
                _buildEmailAddress((currentUser?.email).toString()),
                _buildSignout(),
              ],
            )
          ),
        ),
      ),
    );
  }
}