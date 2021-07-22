import 'package:flutter/material.dart';
import '../partials/sizeconfig.dart';

class NoChatroomsPage extends StatefulWidget {
  @override
  _NoChatroomsPageState createState() => _NoChatroomsPageState();
}

class _NoChatroomsPageState extends State<NoChatroomsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.70,
      child:Center(
        child: Text(
          "You have no contacts as of the moment.",
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