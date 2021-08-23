import 'package:core/Animation.dart';
import 'package:core/Electronics.dart';
import 'package:core/Home.dart';
import 'package:core/MenClothes.dart';
import 'package:core/Saved.dart';
import 'package:core/ShoppingCart.dart';
import 'package:core/WomenClothes.dart';
import 'package:core/jewel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = new GoogleSignIn();

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30, //border color
                      child: Padding(
                        padding: const EdgeInsets.all(2.0), //border size
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage: AssetImage("assets/logo.png"),
                          backgroundColor: Colors.white,
                        ),
                      )),
                  Text(
                    'BuyIT',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'Satisfy'),
                  )
                ]),
            decoration: BoxDecoration(color: Colors.orangeAccent),
          ),
          ListTile(
            title: Text("Home"),
            leading: FaIcon(
              FontAwesomeIcons.home,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          ListTile(
            title: Text("Men's Clothing"),
            leading: FaIcon(
              FontAwesomeIcons.heart,
              color: Colors.blueAccent,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenClothes()));
            },
          ),
          ListTile(
            title: Text("Women's Clothing"),
            leading: FaIcon(
              FontAwesomeIcons.heart,
              color: Colors.pinkAccent,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WomenClothes()));
            },
          ),
          ListTile(
            title: Text('Jewellery'),
            leading: Icon(
              Icons.auto_awesome_sharp,
              color: Colors.yellow.shade800,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => jewel()));
            },
          ),
          ListTile(
            title: Text('Electronics'),
            leading:
                Icon(Icons.devices_other_sharp, color: Colors.green.shade800),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Electronics()));
            },
          ),
          ListTile(
            title: Text('Bookmarks'),
            leading: FaIcon(
              FontAwesomeIcons.solidBookmark,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Saved()));
            },
          ),
          ListTile(
            title: Text('Cart'),
            leading: FaIcon(
              FontAwesomeIcons.shoppingBag,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShoppingCart()));
            },
          ),
          ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout, color: Colors.red.shade900),
              onTap: () {
                FirebaseAuth.instance.signOut();
                _googleSignIn.disconnect();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Anim()),
                    (Route<dynamic> route) => false);
              })
        ],
      ),
    );
  }
}
