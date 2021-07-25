import 'package:flutter/cupertino.dart';
import 'common/packages.dart';
import 'views/authenticate/authenticate.dart';
import 'views/mainPage.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final status;
  Wrapper({ this.status });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user == null){
      return Authenticate();
    }else{
      if(status == true){
        return MainPage();
      }else{
        return Authenticate();  
      }
    }
  }
}
