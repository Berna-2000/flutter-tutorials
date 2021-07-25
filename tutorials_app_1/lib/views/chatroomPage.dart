
// import 'package:chatapp_ferolin/models/chatroom.dart';
// import 'package:chatapp_ferolin/partials/sizeconfig.dart';
// import 'package:chatapp_ferolin/views/emptyConversation.dart';
import 'package:flutter/material.dart';
import 'package:tutorials_app_1/views/emptyConversation.dart';
import '../common/packages.dart';
import '../controller/chatroomController.dart';
import '../models/chatMessages.dart';
import '../models/chatroom.dart';

class ChatRoomPage extends StatefulWidget {
  final String? chattedUser;
  final User? currentUser;
  final chatroomId;
  final hasNoConversation;
  ChatRoomPage({this.chattedUser, this.currentUser, this.chatroomId, this.hasNoConversation});
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  String message='';
  String messageId = "";
  TextEditingController messageHolder = TextEditingController();
  bool isFirstTime = true;
  Stream? streamMessages;
  ScrollController _controller = ScrollController();
  bool hasNoConversation = true;
  var numberOfMessages;

  getAndSetMessages() async {
    //some code to get the messages here
    streamMessages = await ChatroomController().retrieveChatroomMessages(widget.chatroomId);
    setState(() {});
  }

  checkMessageBox() async {
    numberOfMessages = await ChatroomController().checkChatroomMessages(widget.chatroomId);
    setState(() {});
  }

  @override
  void initState(){
    getAndSetMessages();
    checkMessageBox();
    setState(() {
      Timer(
        Duration(milliseconds: 300),
        () => _controller
          .jumpTo(_controller.position.maxScrollExtent)
      );
    });
    super.initState();
  }

  Widget _buildMessageBoxRow(){
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(top: 10.0),
      child: Container(
        height: 10 * SizeConfig.heightMultiplier,
        constraints: BoxConstraints(
          minHeight: 10 * SizeConfig.heightMultiplier,
          // maxHeight: 14 * SizeConfig.heightMultiplier,
        ),
        color: Colors.grey,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                color: Colors.white,
                child: TextField(
                  onTap: () {
                    //some code here
                    setState(() {
                      Timer(
                        Duration(milliseconds: 300),
                        () => _controller
                          .jumpTo(_controller.position.maxScrollExtent)
                      );
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  controller: messageHolder,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Write your message here...",
                    contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  ),
                  maxLength: 240,
                  maxLines: 3,
                  onChanged: (input){
                    if(input.length > 240){
                      //some code to stop the user from writing
                      message = input.substring(0,240);
                    }else{
                      message = input;
                    }
                  },
                ),
              ),
            ),
            SizedBox(width: 2 * SizeConfig.heightMultiplier),
            GestureDetector(
              child: Container(
                child: Row(
                  children: [
                    Text("Send"),
                    SizedBox(width: 0.5 * SizeConfig.heightMultiplier),
                    Icon(
                      Icons.send,
                    ),
                  ],
                ),
              ),
              onTap: () {
                //some code here
                //create chatRoom
                if(message.isNotEmpty){
                  var messageSent = DateTime.now();
                  messageId = ChatroomController().generateMessageId();
                  List<String> users = [widget.chattedUser.toString(), (widget.currentUser?.displayName).toString()];
                  ChatroomController().createChatroom(widget.chatroomId, users);
                  // code to retrieve other information
                  ChatMessages newMessage = 
                    new ChatMessages(
                      messageId: messageId,
                      message: message,
                      sender: widget.currentUser?.displayName.toString(),
                      sentTime: messageSent 
                    );
                  // Adds the message to the database
                  ChatroomController().addMessage(widget.chatroomId, newMessage).then((value){
                    Chatroom chatroomUpdates = 
                      new Chatroom(
                        lastMessage: message,
                        lastMessageSentTime: messageSent,
                        lastMessageSender: widget.currentUser?.displayName
                      );
                    //Updates the Chatroom Details
                    ChatroomController().updateLastMessageSent(widget.chatroomId, chatroomUpdates);
                    //Scrolls to the end of the message
                    Timer(
                      Duration(milliseconds: 10),
                      (){ 
                        _controller
                          .jumpTo(_controller.position.maxScrollExtent);
                      }
                    );
                  });
                  //clears the message field
                  setState(() {
                    //Checks number of messages
                    checkMessageBox();
                    hasNoConversation = false;
                    messageHolder.clear();
                    isFirstTime = false;
                    // FocusScope.of(context).unfocus();
                  });
                  messageId = "";
                }
              }
            )
          ],
        )
      ),
    );
  }

  Widget _buildMessages(){
    return StreamBuilder(
      stream: streamMessages,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return EmptyConversation();
        }
        return Container(
          margin: EdgeInsets.only(bottom: 8.0), // 10 supposed to be
          child: ListView.builder(
            controller: _controller,
            padding: EdgeInsets.only(bottom: 70.0, top: 16.0),
            itemCount: (snapshot.data! as QuerySnapshot).docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              DocumentSnapshot messageSnapshot = (snapshot.data as QuerySnapshot).docs[index];
              return Container(
                margin: EdgeInsets.only(bottom: 5.0),
                child: _buildChatMessageTile(messageSnapshot['message'], 
                        widget.currentUser?.displayName == messageSnapshot['sender']),
              );
            }
          )
        );
      }
    );
  }

  Widget _buildChatMessageTile(String thisMessage, bool sentByMe){
    return thisMessage == "" ? Container() :
    Row(
      mainAxisAlignment: 
          sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 0.8 * MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomRight: 
                  sentByMe ? Radius.zero : Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: 
                  sentByMe ? Radius.circular(20.0) : Radius.zero,
            ),
            color: sentByMe ? Colors.lightGreen[400] : Color(0xfff9bcafa),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          padding: EdgeInsets.all(10.0),
          child: Text(
            thisMessage,
          )
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    hasNoConversation = widget.hasNoConversation;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xfff1976d2), 
          title: Text(widget.chattedUser.toString()),
          automaticallyImplyLeading: false,
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.cancel),
              ),
            )
          ],
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              _buildMessages(),
              numberOfMessages == null ? Container() : numberOfMessages > 1 ? Container() : EmptyConversation(),
              _buildMessageBoxRow(),
            ],
          )
        ),
      )
    );
  }
}