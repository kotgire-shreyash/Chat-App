import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Colors.deepPurpleAccent);
    FlutterStatusbarcolor.setStatusBarColor(Colors.deepPurpleAccent);

    final Shader gradientText = LinearGradient(
        colors: [Colors.white, Colors.blueAccent.shade400],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [.3, .5]).createShader(Rect.fromLTWH(50, 60, 200.0, 70.0));

    return Scaffold(
        body: Center(
            child: Container(
      color: Colors.deepPurpleAccent.shade200,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 150),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Form(
                        child: Container(
                          child: Icon(
                            FlutterIcons.phone_android_mdi,
                            size: 120,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 65,
                        bottom: 75,
                        child: Container(
                          color: Colors.deepPurpleAccent.shade200,
                          height: 70,
                          width: 70,
                          child: Icon(
                            FlutterIcons.chat_mdi,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Container(
                      margin: EdgeInsets.only(left: 15, top: 25),
                      child: GradientText(
                        "justchat",
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [
                              .45,
                              .1
                            ],
                            colors: [
                              Colors.white,
                              Colors.deepPurpleAccent.shade700
                            ]),
                      )

                      /*Text(
                      "justchat",
                      style: TextStyle(
                          //color: Colors.blueAccent,
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),*/
                      ),
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
            // The color must be set to white for this to work
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    final Shader gradientText = LinearGradient(
        colors: [Colors.white, Colors.blueAccent.shade400],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [.3, .5]).createShader(Rect.fromLTWH(50, 60, 200.0, 70.0));

    return Scaffold(
        body: Center(
            child: Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 150),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Form(
                        child: Container(
                          child: Icon(
                            FlutterIcons.phone_android_mdi,
                            size: 120,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 65,
                        bottom: 75,
                        child: Container(
                          color: Colors.white,
                          height: 70,
                          width: 70,
                          child: Icon(
                            FlutterIcons.chat_mdi,
                            size: 70,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Container(
                      margin: EdgeInsets.only(left: 15, top: 25),
                      child: GradientText(
                        "justchat",
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [
                              .45,
                              .5
                            ],
                            colors: [
                              Colors.blue.shade800,
                              Colors.blue.shade400
                            ]),
                      )

                      /*Text(
                      "justchat",
                      style: TextStyle(
                          //color: Colors.blueAccent,
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent),
                    ),*/
                      ),
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
            // The color must be set to white for this to work
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
*/
