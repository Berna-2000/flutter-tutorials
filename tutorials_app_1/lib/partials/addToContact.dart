/*
  ALWAYS CHECK YOUR IMPORTS AND READ THE ERRORS.
  If you have a Partials folder, place this in your partials.
  
  You will use this in your usersList.dart file
 */
import '../controller/chatroomController.dart';
import '../models/chatMessages.dart';
import '../models/chatroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../partials/sizeconfig.dart';
import '../models/appUsers.dart';
import '../common/packages.dart';
import '../views/chatroomPage.dart';


showAddToContactAlert(BuildContext context, AppUser addedUser, User currentUser, String chatID){
  String content = "Would you like to add "+addedUser.username.toString()+"?";
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Add contact',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Montserrat"
          )
        ),
        content: Text(
          content,
          style: TextStyle(
            fontSize: 2 * SizeConfig.textMultiplier,
            fontFamily: "Montserrat"
          )
        ),
        actions: [
          TextButton(
            child: Text(
              'NO',
              style: TextStyle(
                color: Colors.red,
                fontFamily: "Montserrat"
              )
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'OKAY',
              style: TextStyle(
                color: Colors.red,
                fontFamily: "Montserrat"
              )
            ),
            onPressed: () {
              //some code here to create the chat and navigate
              List<String> users = [addedUser.username.toString(), currentUser.displayName.toString()];
              ChatroomController().createChatroom(chatID, users);
              var messageSent = DateTime.now();
              var messageId = ChatroomController().generateMessageId();
              ChatMessages newMessage = 
                new ChatMessages(
                  messageId: messageId,
                  message: "",
                  sender: currentUser.displayName,
                  sentTime: messageSent,
                );
              //Adds the message to the database
              ChatroomController().addMessage(chatID, newMessage).then((value){
                Chatroom chatroomUpdates = 
                  new Chatroom(
                    lastMessage: "",
                    lastMessageSentTime: messageSent,
                    lastMessageSender: currentUser.displayName
                  );
                //Updates the Chatroom Details
                ChatroomController().updateLastMessageSent(chatID, chatroomUpdates);
              });
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>
                  ChatRoomPage(
                    chattedUser: addedUser.username, 
                    currentUser: currentUser, 
                    chatroomId: chatID,
                    hasNoConversation: true,
                    )));
            },
          )
        ]
      );
    }
  );
}