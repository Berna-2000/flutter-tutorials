import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../partials/sizeconfig.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const spinkit = SpinKitChasingDots(
    //                   color: Colors.tealAccent,
    //                   size: 50.0,
    //                 );
    return Container(
      height: SizeConfig.screenHeight,
      color: Colors.white,
      child: Center(
        // child: SpinKitChasingDots(color: Colors.tealAccent[200]),
        child: Text(
          "Loading...",
          style: TextStyle(
            fontSize: 2*SizeConfig.textMultiplier
          ),
        )
      ),
    );
  }
}
