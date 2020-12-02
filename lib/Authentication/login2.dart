import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarColor(Colors.pinkAccent);

    var body = SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade300,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      stops: [.4, .6],
                      colors: [Colors.redAccent, Colors.pink.shade600])),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(top: 180, left: 35),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 280),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
            ),
            Container(
              alignment: Alignment.center,
              //color: Colors.grey.shade100,
              margin: EdgeInsets.only(top: 320),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 35, top: 0),
                    child: Text(
                      "Username",
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(35)),
                    height: 60,
                    width: 370,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(
                                color: Colors.grey.shade200, width: 2.5)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(
                                color: Colors.grey.shade100, width: 1.5)),
                        hintText: "email or phone number",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade400, fontSize: 15),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey.shade500,
                          size: 27,
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 35, top: 0),
                    child: Text(
                      "Password",
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(35)),
                    height: 60,
                    width: 370,
                    child: TextField(
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(
                                color: Colors.grey.shade200, width: 2.5)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(
                                color: Colors.grey.shade100, width: 1.5)),
                        hintText: "password",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade400, fontSize: 15),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey.shade500,
                          size: 27,
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  Container(
                    //width: 150,
                    //color: Colors.black,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 25, top: 10, bottom: 20),
                    child: Text("Forgot password?",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      //color: Colors.black,
                      margin: EdgeInsets.only(top: 40),
                      height: 40,
                      width: 250,
                      child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          isExtended: true,
                          //backgroundColor: Colors.black,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.pinkAccent),
                              height: 40,
                              width: 250,
                              //color: Colors.white,
                              child: Center(child: Text("Login"))),
                          onPressed: () async {})),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: GestureDetector(
                          child: Center(
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          onTap: () {}))
                ],
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(body: body);
  }
}
