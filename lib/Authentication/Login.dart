import 'package:JustChat/Profiles.dart';
import 'package:JustChat/staticVars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue.shade900);

    staticVars.authc = FirebaseAuth.instance;

    bool islogged = false;
    bool issigned = false;

    //Signup
    var signupBody = SingleChildScrollView(
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
              color: Colors.redAccent.shade400,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(top: 120, left: 35),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 220),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
            ),
            Container(
              alignment: Alignment.center,
              //color: Colors.grey.shade100,
              margin: EdgeInsets.only(top: 265),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 35, top: 0),
                    child: Text(
                      "Username",
                      style: TextStyle(
                          color: Colors.redAccent.shade400,
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
                        hintText: "email id",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade400, fontSize: 15),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey.shade500,
                          size: 27,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          staticVars.username1 = value;
                        });
                      },
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
                      "Phone Number",
                      style: TextStyle(
                          color: Colors.redAccent.shade400,
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
                        hintText: "phone number",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade400, fontSize: 15),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey.shade500,
                          size: 27,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          staticVars.mobile = value;
                        });
                      },
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
                          color: Colors.redAccent.shade400,
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
                      onChanged: (value) {
                        setState(() {
                          staticVars.password1 = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                      //color: Colors.black,
                      margin: EdgeInsets.only(top: 40),
                      height: 50,
                      width: 250,
                      child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          isExtended: true,
                          //backgroundColor: Colors.black,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.redAccent.shade400),
                              height: 70,
                              width: 250,
                              //color: Colors.white,
                              child: Center(child: Text("Sign up"))),
                          onPressed: () async {
                            if (staticVars.username1 != null &&
                                staticVars.password1 != null) {
                              setState(() {
                                issigned = true;
                              });

                              var result;
                              try {
                                result = await staticVars.authc
                                    .createUserWithEmailAndPassword(
                                  email: staticVars.username1,
                                  password: staticVars.password1,
                                );
                                print("this is result \n");
                                print(staticVars.authc.currentUser.uid);
                                print(staticVars.username1);
                                print(staticVars.password1);
                                print(staticVars.mobile);
                                await staticVars.fsconnect
                                    .collection("user")
                                    .doc(staticVars.authc.currentUser.uid)
                                    .set(
                                  {
                                    "Name": staticVars.username1,
                                    "mob": staticVars.mobile,
                                    "password": staticVars.password1,
                                  },
                                );
                                setState(() {
                                  issigned = false;
                                });
                              } catch (e) {
                                print(e);
                              }

                              print("RESULT = $result");
                              Navigator.pop(context);
                            } else {
                              //AppToast("No credentials found");
                            }
                          })),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      child: GestureDetector(
                          child: Center(
                            child: Text(
                              "Back to the login page",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          onTap: () async {
                            FlutterStatusbarcolor.setStatusBarColor(
                                Colors.blue.shade900);
                            Navigator.pop(context);
                          }))
                ],
              ),
            )
          ],
        ),
      ),
    );

    Future ProfileConfirm() async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog();
          });
    }

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
              color: Colors.blue.shade900,
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
                          color: Colors.blue.shade900,
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
                      onChanged: (value) {
                        setState(() {
                          staticVars.username = value;
                        });
                      },
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
                          color: Colors.blue.shade900,
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
                      onChanged: (value) {
                        setState(() {
                          staticVars.password = value;
                        });
                      },
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
                      height: 50,
                      width: 250,
                      child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          isExtended: true,
                          //backgroundColor: Colors.black,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.blue.shade900),
                              height: 70,
                              width: 250,
                              //color: Colors.white,
                              child: Center(child: Text("Login"))),
                          onPressed: () async {
                            var retrieved, result2, temp;
                            if (staticVars.username != null &&
                                staticVars.password != null) {
                              setState(() {
                                islogged = true;
                              });
                              try {
                                result2 = await staticVars.authc
                                    .signInWithEmailAndPassword(
                                        email: staticVars.username,
                                        password: staticVars.password);
                                print(staticVars.authc.currentUser.uid);
                                retrieved = await staticVars.fsconnect
                                    .collection("user")
                                    .doc(staticVars.authc.currentUser.uid)
                                    .get();

                                print(retrieved.data());
                                temp = retrieved.data();

                                staticVars.mail = temp["Name"];
                                staticVars.dob = temp["dob"];
                                staticVars.lastLogin = staticVars
                                    .authc.currentUser.metadata.lastSignInTime;

                                setState(
                                  () {
                                    islogged = false;
                                  },
                                );
                              } catch (e) {
                                print(e);
                                setState(
                                  () {
                                    islogged = false;
                                  },
                                );
                              }

                              print(result2);
                              if (result2 != null) {
                                setState(
                                  () {
                                    islogged = false;
                                  },
                                );
                                //AppToast("Logged in");
                                print('logged in');
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  //return Profile();
                                  if (temp["ProfileName"] != null &&
                                      temp["ProfilePic"] != null &&
                                      temp["ProfileDOB"] != null)
                                    return Scaffold(
                                        body: AlertDialog(
                                            content: Card(
                                      elevation: 15,
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Center(
                                                    child: Text(
                                                      "Continue with the Profile",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .blue.shade900,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: IconButton(
                                                      icon: Icon(FlutterIcons
                                                          .pencil_alt_faw5s),
                                                      onPressed: () async {
                                                        return Profile();
                                                      }),
                                                )
                                              ],
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              height: 200,
                                              width: 200,
                                              child: Image.file(
                                                  temp["ProfilePic"]),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    "Name : ",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .redAccent.shade400,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    temp["ProfileName"],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade300,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    "DON : ",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .redAccent.shade400,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    temp["ProfileDOB"],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade300,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 25, bottom: 0),
                                              height: 45,
                                              width: 300,
                                              child: FloatingActionButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30))),
                                                isExtended: true,
                                                //backgroundColor: Colors.black,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        //color: Colors.deepPurpleAccent.shade200
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .centerLeft,
                                                            end: Alignment
                                                                .centerRight,
                                                            colors: [
                                                              Colors.redAccent
                                                                  .shade200,
                                                              Colors.redAccent
                                                                  .shade700
                                                            ])),
                                                    height: 50,
                                                    width: 300,
                                                    //color: Colors.white,
                                                    child: Center(
                                                        child: Text(
                                                      "Continue",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 15),
                                                    ))),

                                                onPressed: () async {},
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )));
                                  else
                                    return Profile();
                                }));
                              }
                            } else {
                              //AppToast("No Credentials found");
                            }

                            /*Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Profile();
                            }));*/
                          })),
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
                          onTap: () async {
                            FlutterStatusbarcolor.setStatusBarColor(
                                Colors.redAccent.shade400);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Scaffold(
                                body: signupBody,
                              );
                            }));
                          }))
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

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {}
}
