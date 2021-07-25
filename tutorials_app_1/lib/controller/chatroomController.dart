/*
  PLACE THIS IN YOUR CONTROLLER FOLDER

  --------------------------------------------------------------------------------
  Notice that there is one import commented out and that is the chatMessages.dart.

  ChatMessages.dart is a model. Before you can uncomment that, I want you guys to 
  create a model called "ChatMessages", which have the following items and their 
  data type in parentheses.

    * messageId (String) 
    * message (String)
        - In the chatroom collection, you will have another collection called "messages". 
          So, each message sent between two users will become a document, if that makes sense.
          If you are still confused about the difference between a collection and a document,
          kindly refer to the firestore database we made. The labels are there, and maybe it is
          much easier to understand if you look at the actual DB instead of reading what I'm writing here.
    * sender (String)
    * sentTime (DateTime)
  --------------------------------------------------------------------------------

  --------------------------------------------------------------------------------
  NOTE: We are going to be importing a package called random string. You guys already
  know how to do that. I've already imported it in this file. 
  --------------------------------------------------------------------------------

  This is the Chatroom Controller. Basically, this is how you are able to enter a chatroom specific to a person. 
  I don't think you'd like it if you wanted to talk to someone named "Jennen Montejo", but instead,
  Messenger opens the chatroom of "Berna Ferolin".

 */

import '../common/packages.dart';
import 'package:random_string/random_string.dart';
import '../models/chatMessages.dart';
import '../models/chatroom.dart';
import '../services/backend_auth.dart';

class ChatroomController {
  CollectionReference chatroom =
      FirebaseFirestore.instance.collection('chatroom');

  /*
    In order for us to have a unique chatroom,
    we will be the one generating the Chatroom Id,
    and it will be in the format:

    FirstName_SecondName
    The method below is how we're going to get that format.
    It basically creates the name in alphabetical order. What I mean by that is,
    if, for example, you have 2 different users called "Ben" and "Marsha", the format of the 
    chatroom ID is going to be "Ben_Marsha" because 'B' comes before 'M'.

    In the same way, if 'Ben' were talking with 'Arnold', the chatroom ID would then be
    "Arnold_Ben", since 'A' comes before 'B'.
   */
  generateChatroomId(String a, String b){
    if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }else{
      return "$a\_$b";
    }
  }

  /*
    In Sir's requirement, we are not supposed to be able to add a person to our contacts list 
    IF WE HAVE ALREADY TALKED TO OR CONTACTED THAT PERSON.
    This will result in duplication. 

    To counter that, we have the method called "checkIfContactExists()" which accepts the chatroomID,
    so that we are able to decide if we should add the person (if we haven't added them yet), or 
    display and error message (because we have already added them before).

    It returns true if such a document exists, and null if it doesn't.
   */
  Future checkIfContactExists(String chatroomID) async {
    final snapShot = await chatroom.doc(chatroomID).get();
      if(snapShot.exists){
        return true;
      }else{
        return null;
      }
  }
  
  /*
    This is the createChatroom() function, which accepts the generated chatroomID and the 
    array or list of users (it is vital to know who the participants of the conversation are).
   */
  createChatroom(String chatroomId, List<String>users){
    return chatroom.doc(chatroomId).set({
      'userArray':users,
      'lastMessage': "",
      'lastMessageSender': "",
      'lasMessageSentTime': DateTime.now(),
    });
  }

  /*
    Every time a message is sent, this method is always called, so that 
    we are aware and we can check in our DB who the last sender was, when the
    last message was sent, and what the last message sent was.

    So, we are going to be passing our chatroomID (so that we know which chatroom
    we are going to be updating), and a variable of Chatroom (this is our model class)
    data type
   */
  updateLastMessageSent(String chatroomID, Chatroom chatroomUpdates){
    return chatroom
      .doc(chatroomID)
      .update({
        'lastMessage': chatroomUpdates.lastMessage,
        'lastMessageSentTime': chatroomUpdates.lastMessageSentTime,
        'lastMessageSender': chatroomUpdates.lastMessageSender
      })
        .then((value) => print("Chat Room updated"))
        .catchError((e) => print("Failed to update Chat Room: $e"));  
  }


  /*  
    Remember when I said that every message sent between users is a new document?
    Recall that each document must have an ID.

    So, in short, everytime we send a message, we ALWAYS call this method.
   */
  generateMessageId(){
    return randomAlphaNumeric(12);
  }

  /*
    ---------------------------------------------------------
    NOTE: 
    ONLY UNCOMMENT THE METHOD BELOW IF YOU ALREADY HAVE YOUR 
    CHATMESSAGES MODELS!!!
    ---------------------------------------------------------

    What addMessage() method basically does is it adds the message
    , that you intend to send, to your DB
   */
  addMessage(String chatroomID, ChatMessages chatMessages) async{
    return chatroom.doc(chatroomID)           // it goes to your specific chatroom
      .collection("chats")                    // and searched for the "chats" collection, which basically contains all the documented messages
      .doc(chatMessages.messageId).set({      // it creates the document with the specified ID
        'message': chatMessages.message,      // and sets the message details
        'sender': chatMessages.sender,
        'sentTime': chatMessages.sentTime,
        'deleted': false,
    });
  }

  /*
    What this method does is it gets all the messages in your chatroom
    (for example, if Vin is talking with Jennen, then it gets the messages
    stored in the chatroom called "Jennen_Vin") and then sends it to the stream.

    This way, we can call on this method from the front end,
    and build a list of the messages so that they are displayed. 
   */
  Future<Stream<QuerySnapshot>> retrieveChatroomMessages(String chatroomID) async{
    return chatroom.doc(chatroomID)
      .collection("chats")
      .orderBy("sentTime", descending: false)
      .snapshots();
  }

  /*
    This method checks if there are messages sent between you and the user.

    * If there are no messages yet, then the display should be "You can now chat
      with this person.".
    * Otherwise, you display the messages 
   */
  Future checkChatroomMessages(String chatroomID) async {
    final chatroomState = await chatroom.doc(chatroomID)
      .collection("chats")
      .orderBy("sentTime", descending: false)
      .get();
    return chatroomState.docs.length;
  }

  /*
    Similar to obtaining the messages and sending it down a stream,
    we are now obtaining ALL OF THE CHATROOMS (of course, only the chatrooms
    where we are in).

    If I am Bern, I am not supposed to see a chatroom meant for Jennen and Vin only
    (unless of course if it's a GC)
   */
  Future<Stream<QuerySnapshot?>?> retrieveChatrooms() async { // include in your changes
    try{
      String thisUser;
      dynamic user = await AuthenticationMethods().getCurrentUser();
      thisUser = user.displayName;
      return chatroom
        .orderBy("lastMessageSentTime", descending: true)
        .where("userArray", arrayContains: thisUser)
        .snapshots();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<bool> checkForChatrooms() async {
    String thisUser;
    dynamic user = await AuthenticationMethods().getCurrentUser();
    thisUser = user.displayName;
    final checker = await chatroom
      .orderBy("lastMessageSentTime", descending: true)
      .where("userArray", arrayContains: thisUser)
      .get();
    if(checker.docs.isEmpty){
      print("No Contacts");
      return true;
    }else{
      print("Already in Contacts");
      return false;
    }
  }
} 