import 'package:tutorials_app_1/views/sample.dart';
import 'common/packages.dart';
import 'views/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Here we use stream that gives us information about the user
    // if (user == null) {
    //   return Authenticate();
    // } else {  
    //   if(status == true){
    //     return MainPage();
    //   }else{
    //     return Authenticate();
    //   }
    // }
    return MainPage();
  }
}
