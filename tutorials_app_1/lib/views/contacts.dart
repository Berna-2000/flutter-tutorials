import 'package:flutter/material.dart';
import 'package:tutorials_app_1/controller/userController.dart';
import 'package:tutorials_app_1/partials/usersList.dart';
import 'package:tutorials_app_1/services/backend_auth.dart';
import 'package:tutorials_app_1/views/noChatrooms.dart';
import '../partials/sizeconfig.dart';
import '../common/packages.dart';
import 'package:provider/provider.dart';
import '../models/appUsers.dart';
import '../controller/chatroomController.dart';
import '../partials/loading.dart';
import '../partials/chatroomList.dart';


class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Stream? streamChatrooms, streamSearchedUsers;
  String? chatroomId;
  User? user;
  String? currentUser;
  String searchEmail = "";
  dynamic hasNoContact = true;
  bool isEmpty = true;
  bool isEntered = false;
  final searchHolder = TextEditingController();

  /*
    This function is called from the initState method and gets all of the chatrooms of the user if any. 
    Otherwise, our page should display "You have no contacts..."
   */
  getChatroomList() async {
    user = await AuthenticationMethods().getCurrentUser();
    currentUser = user?.displayName;
    streamChatrooms = await ChatroomController().retrieveChatrooms();
    dynamic checker = await ChatroomController().checkForChatrooms();
    hasNoContact = checker;
    setState(() {});
  }

  displayContacts(){
    setState(() {
      hasNoContact = false;
    });
  }

  /*
    Again, remember that initState is the first thing that ContactPage calls once the widget is built.
    Originally, when we have contacts, we want to see them on our page instead of seeing "You have no contacts 
    as of the moment."
    Which is why, we will be getting the list of chatrooms available
    (like your messenger where you see the list of people whom you have already chatted with before)
   */
  @override
  void initState(){
    getChatroomList();
    super.initState();
  }

  onSearchButtonClick(String userEmail) async {
    streamSearchedUsers = await UserController().getUserbyEmail(userEmail);
    setState(() {});
  }

  Widget _buildSearchBar(){
    return Row(
      children: [
        isEntered ? Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: (){
              //some code to go back to the list of contacts
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
              if(input.isNotEmpty){
                setState(() {
                  isEntered = true;
                });
                searchEmail = input;
                onSearchButtonClick(searchEmail);
              }
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


  /*
    Next, we have a method called buildChatroomsListRow which essentially builds the list of your contacts.
    It has a streamBuilder, which is similar to StreamProviders except that you're very much sure
    that there will definitely be a stream of data. 
   */
  Widget _buildChatroomsListRow() {
    return StreamBuilder(
      stream: streamChatrooms, //this is from your getChatroomsList method which you called in your initState
      builder: (context,snapshot){
        if(!snapshot.hasData){ //Remember stream sends whatever data is available. So if it has no data YET, it shows the loading screen
          return Loading();
        }
        return ListView.builder( //Your list is going to be built with the help of the ListView builder
          itemCount: (snapshot.data as QuerySnapshot).docs.length, //If you have data which is more than 0, this will be your item count
          shrinkWrap: true,                                         
          itemBuilder: (context, index){
            DocumentSnapshot chatroomSnapshot = (snapshot.data as QuerySnapshot).docs[index];
            String chattedUser = chatroomSnapshot.id.replaceAll(currentUser.toString(), "").replaceAll("_", "");
            String emailAddress = user!.email.toString();
            String lastMessage = chatroomSnapshot['lastMessage'];
            var isEmptyMessages = (chatroomSnapshot.data() as dynamic).isEmpty;
            bool hasNoConversation = isEmptyMessages ? true : false;
            hasNoContact = false;
            return ChatroomList(
              emailAddress: emailAddress, 
              lastMessage: lastMessage, 
              chattedUser: chattedUser,
              currentUser: user,
              hasNoConversation: hasNoConversation,
            );
          },
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: StreamProvider<List<AppUser?>?>.value(
          value: UserController().retrieveAllUsers,
          initialData: [],
          child: Container(
            height: SizeConfig.screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical:20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  // hasNoContact ? NoChatroomsPage() : _buildChatroomsListRow()
                  MultiProvider(
                    providers: [
                      StreamProvider<User?>(create: (context)=> AuthenticationMethods().user, initialData: null),
                    ],
                    child: isEntered ? UsersList(emailAddress: searchEmail,) : hasNoContact ? NoChatroomsPage() : _buildChatroomsListRow(),
                  ),
                  // isEntered ? UsersList(emailAddress: searchEmail,) : hasNoContact ? NoChatroomsPage() : _buildChatroomsListRow(),
                ],
              )
            ),
          ),
        ),
      )
    );
  }
}