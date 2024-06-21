
import 'package:boxtia_inventory/Screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,required});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String? compName;

  // @override
  // void initState() {
  //   super.initState();
  //   readCompName();
  // }

  // Future<void> readCompName() async {
  //   List<userModel> users = await getAllUsers();
  //   if (users.isNotEmpty) {
  //     setState(() {
  //       compName = users.last.compName;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //GRID ICONS

    final List<IconData> GIcon = [
      FontAwesome5.award, //monthly sale
      FontAwesome5.boxes, //total stock
      Icons.add_shopping_cart_outlined, //add purchase
      Typicons.folder_add, //Add sales
      Icons.unarchive_outlined, //Today sales
      FontAwesome5.cart_arrow_down, //today purchase
      Typicons.warning_empty, //Outof Stock
    ];

    //GRID TEXT

    final List<String> GText = [
      "Mothly\nSales",
      "Total\nStock",
      "Add\nPurchase",
      "Add\nSales",
      "Today\nSales",
      "Today\nPurchase",
      "Out Of\nStock"
    ];

    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            elevation: 10,
            backgroundColor: Color.fromARGB(255, 21, 127, 213),
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                // compName==null?
                "BOXTIA",
                // :compName!,
                
                style: GoogleFonts.mogra(
                  textStyle: const TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 30,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            actions: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                     

                      showDialog(
                        context: context,
                        builder: (ctx1) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content: const Text(
                                'Are you sure,do you want to logout ? !!!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx1).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx1).push(
                                    MaterialPageRoute(
                                      builder: (ctx1) => welcomePage(),
                                    ),
                                  );
                                  signout();
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      MfgLabs.logout,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      "HOME",
                      style: GoogleFonts.mogra(
                        textStyle: const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            toolbarHeight: 85,
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: GridView.builder(
              itemCount: 7,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ClipRRect(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: Color.fromARGB(255, 12, 121, 211),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25.0, right: 60),
                              child: Icon(
                                GIcon[index],
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              GText[index],
                              style: GoogleFonts.mogra(
                                textStyle: const TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontSize: 18,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 72.0),
            child: FloatingActionButton(
              splashColor: Colors.lightBlueAccent,
              elevation: 20,
              onPressed: () {},
              child: Icon(
                MfgLabs.plus,
                size: 25,
              ),
              backgroundColor: Color.fromARGB(255, 21, 127, 213),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(right: 85.0),
            child: ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: BottomAppBar(
                shadowColor: Colors.transparent,
                shape: const CircularNotchedRectangle(),
                notchMargin: 10.0,
                color: Color.fromARGB(255, 21, 127, 213),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            FontAwesome5.boxes,
                            color: Colors.white,
                          ),
                          Text(
                            'Stock',
                            style: GoogleFonts.mogra(
                              textStyle: const TextStyle(
                                color: Colors.cyanAccent,
                                fontSize: 10,
                                letterSpacing: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Typicons.user_outline,
                            color: Colors.white,
                          ),
                          Text(
                            'Profile',
                            style: GoogleFonts.mogra(
                              textStyle: const TextStyle(
                                color: Colors.cyanAccent,
                                fontSize: 10,
                                letterSpacing: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            FontAwesome.product_hunt,
                            color: Colors.white,
                          ),
                          Text(
                            'Product',
                            style: GoogleFonts.mogra(
                              textStyle: const TextStyle(
                                color: Colors.cyanAccent,
                                fontSize: 10,
                                letterSpacing: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  signout() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => welcomePage()), (route) => false);
  }
}
