import 'package:apka_do_nauki_od_zera/main.dart';
import 'package:apka_do_nauki_od_zera/mainWindow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';//importowanie lottie, splash screen


class StartingAnimation extends StatefulWidget {
  @override
  _StartingAnimationState createState() => _StartingAnimationState();
}

class _StartingAnimationState extends State<StartingAnimation>{

  @override
  void initState() {
    super.initState();
  Future.delayed(Duration(seconds: 4),(){
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return MyApp();
    // }));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
         return MyApp();
       }));
  });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SizedBox(height: 300,width: 300, child: Lottie.asset("assets/lottie/login.json")),
          //home: SizedBox(height: 300,width: 300, child: Lottie.asset("assets/lottie/login.json")),
      );
  }
}
