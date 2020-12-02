import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'Authentication/Login.dart';
import 'Splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: Splash(),
        home: AnimatedSplashScreen(
            function: () async {},
            splashIconSize: double.infinity,
            duration: 5000,
            splash: Splash(),
            nextScreen: Auth(),
            //splashTransition: null,
            //pageTransitionType: PageTransitionType.leftToRightWithFade,
            backgroundColor: Colors.grey.shade900));
  }
}
