import '../common/packages.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      color: Colors.white,
      child: Center(
        child: Text("Loading...")
        // child: SpinKitChasingDots(color: Colors.tealAccent[200]),
      ),
    );
  }
}