import 'package:flutter/material.dart';
import '../partials/sizeconfig.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitRing(
                      color: Colors.tealAccent
                    );
    return Container(
      height: SizeConfig.screenHeight,
      color: Colors.white,
      child: Center(
        child: spinkit
      ),
    );
  }
}
