import 'dart:async';

import 'package:aavinposfro/presentation/screens/LoginScreens/login_screen.dart';
import 'package:aavinposfro/presentation/screens/home/Home.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => loadData());
  }

  void loadData() {
    // print('Sname:${currentUser.value.userName}');
    try {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
      // if (currentUser.value.auth==false) {
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      // } else {
      //   if(currentUser.value.userName=='admin'){
      //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>AdminCreatePage()), (route) => false);
      //   }
      //   else{
      //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>UserPage()), (route) => false);
      //   }
      // }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              height: 175,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                // border: Border.all(color: Colors.blueAccent,width: 2),
                image: DecorationImage(
                  image: AssetImage('assets/aavin_logo_xl.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            SizedBox(height: 100,),
            Text(
              "Welcome",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontStyle: FontStyle.italic,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              "TO",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontStyle: FontStyle.italic,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('Aavin POS !',
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                    ),
                    speed: const Duration(
                      milliseconds: 100,
                    )),
              ],
              isRepeatingAnimation: true,
              totalRepeatCount: 2,
            ),
            // Text(
            //   "Welcome",
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 23,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // Text(
            //   "TO",
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 23,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // Text(
            //   "Aavin FRO",
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 23,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
