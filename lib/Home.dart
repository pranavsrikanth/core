import 'dart:convert';
import 'package:core/Nav_Bar.dart';
import 'package:core/Saved.dart';
import 'package:core/ShoppingCart.dart';
import 'package:core/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';

List data = [];
Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

// final GoogleSignIn _googleSignIn = new GoogleSignIn();

class _HomeState extends State<Home> {
  void getProduct() async {
    Response response =
        await get(Uri.parse('https://fakestoreapi.com/products'));
    data = jsonDecode(response.body);
    print(data);
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: wait(3),
        builder: (context, snapshot) {
          if (data.length.toString() != '0') {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.orange,
                drawer: NavBar(),
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        backgroundColor: Colors.orangeAccent,
                        pinned: true,
                        snap: true,
                        floating: true,
                        expandedHeight: height * 0.4,
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Saved()));
                              },
                              icon: Icon(
                                Icons.bookmark,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShoppingCart()));
                              },
                              icon: Icon(
                                Icons.shopping_bag,
                                color: Colors.white,
                              )),
                        ],
                        flexibleSpace: new FlexibleSpaceBar(
                            title: Text(
                              "BuyIT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // fontFamily: 'Algerian',
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                            centerTitle: true,
                            background: Container(
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1556871739-a8578b26a7dd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1565&q=80"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                      ),
                    ];
                  },
                  body: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: EdgeInsets.all(height * 0.009),
                          child: Card(
                            elevation: height * 0.005,
                            color: Colors.black,
                            child: Container(
                                height: height * 0.35,
                                width: width * 0.87,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * 0.3,
                                          width: width * 0.41,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            image: new DecorationImage(
                                              image: NetworkImage(
                                                  data[index]["image"]),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.05,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: height * 0.16,
                                            width: width * 0.30,
                                            color: Colors.black,
                                            child: Text(
                                              data[index]["title"],
                                              style: TextStyle(
                                                  fontFamily: 'STIXTwoText',
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.025,
                                          ),
                                          Center(
                                            child: Card(
                                              elevation: height * 0.005,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Colors.white,
                                                ),
                                                height: height * 0.03,
                                                width: width * 0.30,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Center(
                                                    child: Text(
                                                      '\$ ' +
                                                          data[index]["price"]
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'STIXTwoText',
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.04,
                                          ),
                                          Center(
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Cart.add(data[index]);
                                                      Toast.show(
                                                          "Item Added to Cart",
                                                          context,
                                                          duration:
                                                              Toast.LENGTH_LONG,
                                                          gravity:
                                                              Toast.BOTTOM);
                                                    },
                                                    icon: Icon(
                                                      Icons.add_shopping_cart,
                                                      color: Colors.white,
                                                    )),
                                                SizedBox(
                                                  width: width * 0.001,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      saved.add(data[index]);
                                                      Toast.show(
                                                          "Item Saved to Bookmarks",
                                                          context,
                                                          duration:
                                                              Toast.LENGTH_LONG,
                                                          gravity:
                                                              Toast.BOTTOM);
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .bookmark_add_outlined,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }),
                ),
              ),
            );
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }
}
