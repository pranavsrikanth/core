import 'package:core/Nav_Bar.dart';
import 'package:core/Saved.dart';
import 'package:core/ShoppingCart.dart';
import 'package:core/main.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange,
        drawer: NavBar(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                pinned: true,
                snap: true,
                floating: true,
                expandedHeight: height * 0.4,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Saved()));
                      },
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.black,
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
                        color: Colors.black,
                      )),
                ],
                flexibleSpace: new FlexibleSpaceBar(
                    centerTitle: true,
                    background: Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: NetworkImage(item[0]['image']),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: Text(
                      item[0]['title'],
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Center(
                    child: Text(
                      "Description:",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Text(
                      item[0]['description'],
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Center(
                    child: Text(
                      "Price:",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Text(
                      " \$ " + item[0]['price'].toString() + " ",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          backgroundColor: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.orange,
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: height * 0.1,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Cart.add(item[0]);
                      Toast.show("Item Added to Cart", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
                      saved.add(item[0]);
                      Toast.show("Item Saved to Bookmarks", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    },
                    icon: Icon(
                      Icons.bookmark_add_outlined,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
