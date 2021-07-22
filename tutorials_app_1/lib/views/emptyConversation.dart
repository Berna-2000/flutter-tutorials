import 'package:flutter/material.dart';
import '../partials/sizeconfig.dart';

class EmptyConversation extends StatefulWidget {
  @override
  _EmptyConversationState createState() => _EmptyConversationState();
}

class _EmptyConversationState extends State<EmptyConversation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "You can now start a conversation with this person.",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 3 * SizeConfig.textMultiplier,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}