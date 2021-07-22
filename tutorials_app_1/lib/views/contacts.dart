import 'package:flutter/material.dart';
import 'package:tutorials_app_1/views/noChatrooms.dart';
import '../partials/sizeconfig.dart';
import '../common/packages.dart';


class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // Stream streamChatrooms, streamSearchedUsers;
  // String chatroomId;
  // User user;
  // String currentUser;
  String searchEmail = "";
  dynamic hasNoContact = true;
  bool isEmpty = true;
  bool isEntered = false;
  final searchHolder = TextEditingController();

  // getChatroomList() async {
  //   user = await AuthenticationMethods().getCurrentUser();
  //   currentUser = user.displayName;
  //   streamChatrooms = await ChatroomController().retrieveChatrooms();
  //   dynamic checker = await ChatroomController().checkForChatrooms();
  //   hasNoContact = checker;
  //   // if(checker != false){
  //   //   hasNoContact = true;
  //   // }else{
  //   //   hasNoContact = false;
  //   // }
  //   setState(() {});
  // }

  @override
  void initState(){
    // getChatroomList();
    super.initState();
  }

  // onSearchButtonClick(String userEmail) async {
  //   streamSearchedUsers = await UserController().getUserbyEmail(userEmail);
  //   setState(() {});
  // }

  Widget _buildSearchBar(){
    return Row(
      children: [
        isEntered ? Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: (){
              //some code to go back to the list of contacts
              // getChatroomList();
              setState(() {
                searchHolder.clear();
                isEntered = false;
              });
            },
          )
        ) : Container(),
        Expanded(
          child: TextFormField(
            controller: searchHolder,
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value){
              if(value.isNotEmpty){
                isEmpty = false;
              }else{
                isEmpty = true;
              }
              setState(() {
                searchEmail = value;
              });
            },
            onFieldSubmitted: (input) async {
              //changes the view to retrieve results of the query
              // if(input.isNotEmpty){
              //   setState(() {
              //     isEntered = true;
              //   });
              //   searchEmail = input;
              //   onSearchButtonClick(searchEmail);
              // }
            },
            decoration: InputDecoration(
              suffixIcon: isEmpty ? Icon(Icons.search_outlined) : 
                IconButton(
                onPressed: () {
                  setState(() {
                    //Clears the search bar on click
                    isEmpty = true;
                    isEntered = false;
                    searchHolder.clear();
                  });
                },
                icon: Icon(Icons.cancel),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(100.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(100.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(100.0),
              ),
              hintText: 'Search user e-mail'
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildChatroomsListRow(){
  //   return StreamBuilder(
  //     stream: streamChatrooms,
  //     builder: (context,snapshot){
  //       if(!snapshot.hasData){
  //         return Loading();
  //       }
  //       return ListView.builder(
  //         itemCount: snapshot.data.docs.length,
  //         shrinkWrap: true,
  //         itemBuilder: (context, index){
  //           hasNoContact = false;
  //           DocumentSnapshot chatroomSnapshot = snapshot.data.docs[index];
  //           String chattedUser = chatroomSnapshot.id.replaceAll(currentUser, "").replaceAll("_", "");
  //           String emailAddress = user.email;
  //           String lastMessage = chatroomSnapshot['lastMessage'];
  //           var isEmptyMessages = chatroomSnapshot.data().isEmpty;
  //           bool hasNoConversation = isEmptyMessages ? true : false;
  //           return ChatroomList(
  //             emailAddress: emailAddress, 
  //             lastMessage: lastMessage, 
  //             chattedUser: chattedUser,
  //             currentUser: user,
  //             hasNoConversation: hasNoConversation,
  //           );
  //         },
  //       );
  //     }
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: SizeConfig.screenHeight,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical:20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSearchBar(),
                NoChatroomsPage()
                  // isEntered ? UsersList(emailAddress: searchEmail) : hasNoContact ? NoChatroomsPage() : _buildChatroomsListRow(),
                ],
              ),
            ),
        ),
      )
    );
  }
}