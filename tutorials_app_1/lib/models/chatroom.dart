/*
  PLACE THIS IN THE MODELS FOLDER
  
  This is the model for your chatroom. Recall that we will also have a 
  collection called "chatroom" in our Firestore DB.

  Similar to what we did with our users, we are using a model so that
  we have already determined the data and the type of information that we 
  will be needing only and getting.  
 */

class Chatroom {
  List <String>? users = [];
  String? lastMessage;
  DateTime? lastMessageSentTime;
  String? lastMessageSender;
  String? uid;

  Chatroom({this.users, this.lastMessage, this.lastMessageSentTime, this.lastMessageSender, this.uid});
}