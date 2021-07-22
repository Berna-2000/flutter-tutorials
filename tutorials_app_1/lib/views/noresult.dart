// import 'package:chatapp_ferolin/partials/noResult.dart';
import '../partials/sizeconfig.dart';
import 'package:flutter/material.dart';
import '../common/packages.dart';

class NoResultsPage extends StatefulWidget {
  @override
  _NoResultsPageState createState() => _NoResultsPageState();
}

class _NoResultsPageState extends State<NoResultsPage> {

  @override
  void initState() {
    // Timer(Duration(seconds: 1), (){
    //   showNoResultError(context);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.55,
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              width: 80 * SizeConfig.imageSizeMultiplier,
              image: AssetImage('assets/images/noresult.png'),
            ),
            Text(
              "Sorry... It seems like you're lost."
            )
          ] 
        )
      ),
    );
  }
}