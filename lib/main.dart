import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //we are using getx so we have to change this materialApp into GetMaterialApp
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: appname,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
              //TO SET APPBAR ICON COLOR
              iconTheme: IconThemeData(
                color: darkFontGrey,
              ),
              //set elevstion to 0
              elevation: 0.0,
              backgroundColor: Colors.transparent),
          fontFamily: regular,
        ),
        home: const SplashScreen());
  }
}
