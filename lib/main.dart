import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'login.dart';
void main() => runApp(
  MaterialApp(
    title: "Cinetec",
    home: new MyApp()
  )
);

class MyApp extends StatefulWidget {
  AppState createState()=> new AppState();
}
class AppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 10,
      navigateAfterSeconds: Login() ,
      title:Text("Cinetec",
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 20.0
        ),
      ) ,
      gradientBackground: new LinearGradient(colors: [Colors.white, Colors.green], begin: Alignment.center, end: Alignment.bottomCenter),
      styleTextUnderTheLoader:  new TextStyle(),
      loaderColor: Colors.red
    );
  }

}

