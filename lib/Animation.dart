import 'package:core/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Anim extends StatefulWidget {
  @override
  _AnimState createState() => _AnimState();
}

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}

class _AnimState extends State<Anim> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.075),
              Center(
                  child: Text(
                'BuyIT',
                style: TextStyle(
                    fontFamily: 'STIXTwoText',
                    fontSize: 50,
                    color: Colors.orangeAccent.shade400),
              )),
              Container(
                height: height * 0.45,
                width: width,
                child: Lottie.asset('assets/Lottie.json'),
                padding: EdgeInsets.all(8),
              ),
              Hero(
                tag: 'container',
                child: Container(
                  height: height * 0.36,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.zero),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.04),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 35, //border color
                        child: Padding(
                            padding: const EdgeInsets.all(2.0), //border size
                            child: Center(
                              child: CircleAvatar(
                                radius: 33,
                                backgroundImage: AssetImage("assets/logo.png"),
                                backgroundColor: Color(0xfff7f4b4),
                              ),
                            )),
                      ),
                      SizedBox(height: height * 0.03),
                      SizedBox(
                        width: width * 0.86,
                        height: height * 0.10,
                        child: Text(
                          "Your one stop shopping app for Men's Women's clothing as well as jewellery and electronic goods as well!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Engagement',
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            FirebaseService service = new FirebaseService();
                            try {
                              await service.signInwithGoogle();
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (context, _, a) => Home(),
                                      transitionDuration:
                                          Duration(milliseconds: 1000)));
                            } catch (e) {
                              if (e is FirebaseAuthException) {
                                showMessage(e.message!);
                              }
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            color: Color(0xffd4fff7),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff171f28),
                          ),
                          label: Text(
                            "SIGNIN",
                            style: TextStyle(
                              fontFamily: 'Almendra',
                              color: Color(0xffd4fff7),
                              fontSize: 15,
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
