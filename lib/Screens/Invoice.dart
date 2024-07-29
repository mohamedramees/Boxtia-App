import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Home_Page.dart';
import 'package:boxtia_inventory/Screens/Product_Page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  String _businessName = '';
  List<customerModel> _customer = [];

  @override
  void initState() {
    super.initState();
    _fetchBusinessName();
    _fetchCustomer();
  }

  void _fetchBusinessName() async {
    final box = await Hive.openBox<userModel>('boxtiadb');
    List<userModel> users = box.values.toList();
    if (users.isNotEmpty) {
      setState(() {
        _businessName = users[0].bussinessName;
      });
    }
  }

  //FETCH CUTOMER

  void _fetchCustomer() async {
    final box = await Hive.openBox<customerModel>('boxtiacustomerdb');
    List<customerModel> customer = box.values.toList();
    setState(() {
      _customer = customer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 21, 127, 213),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            _businessName.isNotEmpty ? _businessName : "BOXTIA",
            style: GoogleFonts.goldman(
              textStyle: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 25,
                letterSpacing: -1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  "INVOICE",
                  style: GoogleFonts.mogra(
                    textStyle: const TextStyle(
                      decorationColor: Colors.tealAccent,
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        toolbarHeight: 85,
      ),
      body: Column(
        children: _customer.isNotEmpty
            ? _customer.map((customer) => Text(customer.customerNameM)).toList()
            : [Text('No customers found')],
            
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 76.0),
        child: FloatingActionButton(
          splashColor: Colors.lightBlueAccent,
          elevation: 20,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home_Page()));
          },
          child: Text(
            'SELL',
            style: GoogleFonts.arvo(
              textStyle: TextStyle(
                color: Colors.cyanAccent[100],
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 21, 127, 213),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: BottomAppBar(
            shadowColor: Colors.transparent,
            shape: const CircularNotchedRectangle(),
            notchMargin: 10.0,
            color: Color.fromARGB(255, 21, 127, 213),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  tooltip: 'profile',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile_Page(),
                      ),
                    );
                  },
                  icon: Icon(
                    Typicons.user_outline,
                    size: 32,
                  ),
                  color: Colors.white,
                ),
                IconButton(
                  tooltip: 'stock',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Stock_Page(),
                      ),
                    );
                  },
                  icon: Icon(
                    FontAwesome5.boxes,
                    size: 30,
                  ),
                  color: Colors.white,
                ),
                IconButton(
                  tooltip: 'product',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Product_Page(),
                      ),
                    );
                  },
                  icon: Icon(
                    Zocial.paypal,
                    size: 30,
                  ),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
