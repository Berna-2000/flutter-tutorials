/*
  STRONGLY ADVISING YOU TO ALWAYS CHECK YOUR IMPORTS.

  IF IT DOESN'T WORK, THEN MAYBE YOU HAVE TO ADJUST IT 
  ACCORDING TO THE DIRECTORY THAT YOU HAVE
 */

import 'package:flutter/material.dart';
import '../common/packages.dart';
import '../models/appUsers.dart';
import 'package:provider/provider.dart';
import '../views/noresult.dart';
import '../controller/chatroomController.dart';
import 'addToContact.dart';

class UsersList extends StatefulWidget {
  final emailAddress;
  UsersList({this.emailAddress});
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  String chatroomId='';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context); //This listens for any current logged in user. 
    final userSnapshot = Provider.of<List<AppUser?>?>(context) ?? []; //userSnapshot then receives the list of AppUser (essentially the users in our DB)
    final userDisplay = userSnapshot.where((element) => element!.emailAddress == widget.emailAddress)
                          .toList(); //the snapshot is then filtered so that it only lists down users whose email address is the one we searched
    return userDisplay.length == 0 ? NoResultsPage() : //Ternary operator. If there are no users, then display no results. Otherwise, display the list of users
    ListView.builder(
      shrinkWrap: true,
      itemCount: userDisplay.length,
      itemBuilder: (context, index){ 
        /* 
          The index here literally means index as in like array index 2. 
          This is to make sure that if ever there are multiple results, 
          we are aware of the index of the list of results we are accessing

          For example, if we there are two results, if we click the first result,
          the program would pass the details of result at index 0 (result[0])
        */ 
        return GestureDetector(
          onTap: () async {
            if(user?.email == userDisplay[index]?.emailAddress){
              /*
                This condition checks if the user you're clicking is yourself.
                If you are trying to add yourself to your contacts, that should not be and should be considered an error
              */
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Error",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat"
                      )
                    ),
                    content: Text(
                      "You are not allowed to add your own self.",
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
                        },
                      )
                    ]
                  );
                }
              );
            }else{
              //If the user is not yourself, it could either be that the user is not yet your contact OR is already in your contacts
              /*
                TODO:
                  1. Instantiate ChatroomController(). ALWAYS check your imports. 
                  2. Generate a chatroomId using the instantiated ChatroomController (the method for this is in the ChatroomController)
                  3. Check if the chatroom (or the contact) already exists, by supplying the generated chatroomId to the method
                       - Note: the method for this is also in the Chatroom Controller
                       - Note: Check the controller file. If the return type is Future, that means it is an ASYNC function and you would 
                               have to WAIT for the backend to process your request.
                  4. If the chatroom DOES NOT EXIST (check the method called in TODO 3 to see what it returns):
                       -  call the method in the addToContacts.dart file. Don't forget to pass the context, and other details like:
                            * context
                            * userDisplay[index]
                            * user
                            * chatroomId
                       - Check the data types in the method called to see why the objects we passed are as such
                  5. If the contact DOES EXIST, we shouldn't be able to add that person and it shows an error alert
                       - Title: "Failed"
                       - Message: "You both already have a connection."
                  
              */
              ChatroomController chatroomController = new ChatroomController();
              String generatedUID = chatroomController.generateChatroomId(userDisplay[index]!.username.toString(), user!.displayName.toString());
              dynamic doesExist = await chatroomController.checkIfContactExists(generatedUID);
              if (doesExist == null){
                showAddToContactAlert(
                  context, 
                  userDisplay[index]!, 
                  user, 
                  generatedUID);
              }else{
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Failed",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat"
                        )
                      ),
                      content: Text(
                        "You both already have a connection.",
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
                          },
                        )
                      ]
                    );
                  }
                );
              }
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Color(0xfff85b5e6)
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userDisplay[index]!.username.toString(), 
                      style: TextStyle(
                        fontSize: 2.75 * SizeConfig.textMultiplier, 
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      userDisplay[index]!.emailAddress.toString(),
                    ),
                  ],
                ),
              ],
            ),
          )
        );
      }
    );
  }
}