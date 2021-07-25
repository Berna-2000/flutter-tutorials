import 'package:provider/provider.dart';
import 'package:tutorials_app_1/partials/usersList.dart';
import 'package:tutorials_app_1/services/backend_auth.dart';
import 'package:tutorials_app_1/views/authenticate/authenticate.dart';
import 'package:tutorials_app_1/views/verify.dart';
import 'package:tutorials_app_1/wrapper.dart';
import 'common/packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          return OrientationBuilder(
            builder: (context, orientation){
              SizeConfig().init(constraints, orientation);
              return MultiProvider(
                providers: [
                  StreamProvider<User?>(create: (BuildContext context)=>AuthenticationMethods().user, initialData: null,)
                ],
                child: MaterialApp(
                  title: "Chat Application",
                  debugShowCheckedModeBanner: false,
                  home: Wrapper(status: getUser()),
                ),
              );
            }
          );
        }
      );
  }
  Future getUser() async{
    AuthenticationMethods _auth = new AuthenticationMethods();
    User? currentUser;
    await _auth.getCurrentUser().then((result){
      currentUser = result;
      return currentUser?.emailVerified;
    });
  }
}
