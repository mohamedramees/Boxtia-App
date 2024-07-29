import 'dart:io';

import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:boxtia_inventory/Functions/DB_Functions.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Billing_Page.dart';
import 'package:boxtia_inventory/Screens/Product_Page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class SalesPage extends StatefulWidget {
  SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final Map<int, TextEditingController> _countControllers = {};
  final Map<int, int> _quantities = {};

  List<itemModel> _items = [];
  String _businessName = '';

  @override
  void dispose() {
    _countControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchBusinessName();
    _fetchItems();
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

  void _fetchItems() async {
    final box = await Hive.openBox<itemModel>('boxtiaitemdb');
    List<itemModel> items = box.values.toList();
    setState(() {
      _items = items;
      for (int i = 0; i < _items.length; i++) {
        _countControllers[i] = TextEditingController(text: '0');
        _quantities[i] = 0;
      }
    });
  }

  void _updateQuantity(int index, int delta) {
    final currentItem = _items[index];
    int maxCount = int.parse(currentItem.CountM);

    setState(() {
      int newQuantity = (_quantities[index] ?? 0) + delta;

      if (newQuantity >= 0 && newQuantity <= maxCount) {
        _quantities[index] = newQuantity;
        _countControllers[index]?.text = newQuantity.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.safeArea,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.scaffold,
          appBar: AppBar(
            elevation: 10,
            backgroundColor:AppColor.appBar,
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
                      "ADD SALE",
                      style: GoogleFonts.mogra(
                        textStyle: const TextStyle(
                          decorationColor: Colors.tealAccent,
                          color:AppColor.white,
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
          body: _items.isEmpty
              ? Center(child: Text('No items available!!!'))
              : GridView.builder(
                  itemCount: _items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                  ),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    final controller = _countControllers[index];
                    final quantity = _quantities[index] ?? 0;
                    int maxCount = int.parse(item.CountM);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shadowColor: Color.fromARGB(214, 2, 21, 228),
                        color: Color.fromARGB(218, 255, 255, 255),
                        child: ClipRRect(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 9, left: 10, right: 10),
                                child: SizedBox(
                                  // IMAGE
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      File(item.ItemPicM),
                                      width: 130,
                                      height: 90,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              ),
                              // ITEM NAME
                              Text(
                                item.ItemNameM,
                                style: GoogleFonts.robotoSlab(
                                  textStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    letterSpacing: -1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              // PRICE
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text('\u{20B9}'),
                                  ),
                                  Text(
                                    item.PriceM,
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 4, 76, 136),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //COUNT

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'count =',
                                    style: GoogleFonts.robotoSlab(
                                      textStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
                                        letterSpacing: -1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: boxtiaitemdb,
                                      builder: (context, value, child) {
                                        return Text(
                                          value.isEmpty
                                              ? item.CountM
                                              : value.first.CountM.toString(),
                                          style: GoogleFonts.arvo(
                                            textStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 12, 73, 216),
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              ),
                              SizedBox(width: 5),
                              Center(
                                child: Row(
                                  children: [
                                    // COUNT --
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(width: 4),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:AppColor.textFormBorder,
                                            ),
                                            child: IconButton(
                                              icon: Icon(
                                                FontAwesome5.minus,
                                                color:AppColor.white,
                                                size: 22,
                                              ),
                                              onPressed: () {
                                                if (quantity > 0) {
                                                  _updateQuantity(index, -1);
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          // COUNT TEXT FIELD
                                          Container(
                                            width: 70,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:AppColor.textFormBorder,
                                            ),
                                            child: Center(
                                              child: TextFormField(
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      3),
                                                ],
                                                style: GoogleFonts.robotoSlab(
                                                  color:AppColor.white,
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                controller: controller,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 10),
                                                ),
                                                onChanged: (value) {
                                                  int newValue =
                                                      int.tryParse(value) ?? 0;
                                                  if (newValue > maxCount) {
                                                    controller?.text =
                                                        maxCount.toString();
                                                  } else {
                                                    setState(() {
                                                      _quantities[index] =
                                                          newValue;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          // COUNT ++
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:AppColor.textFormBorder,
                                            ),
                                            child: IconButton(
                                              icon: Icon(
                                                FontAwesome5.plus,
                                                color:AppColor.white,
                                                size: 22,
                                              ),
                                              onPressed: () {
                                                _updateQuantity(index, 1);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 76.0),
            child: FloatingActionButton(
              splashColor: Colors.lightBlueAccent,
              elevation: 20,
              onPressed: () {
               List<itemModel> selectedItems = [];
  _quantities.forEach((index, quantity) {
    if (quantity > 0) {
      final updatedItem = _items[index];
      final selectedItem = itemModel(
        ItemNameM: updatedItem.ItemNameM,
        PriceM: updatedItem.PriceM,
        CountM: updatedItem.CountM,
        ItemPicM: updatedItem.ItemPicM,
        CategoryM: updatedItem.CategoryM,
        ColorM: updatedItem.ColorM,
        BrandM: updatedItem.BrandM,
        QuantityM: quantity, 
      );
      selectedItems.add(selectedItem);
    }
  });
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BillingPage(
        selectedItems: selectedItems,
      ),
    ),
  );
              },
              child: Text(
                'BILL',
                style: GoogleFonts.arvo(
                  textStyle: TextStyle(
                    color: Colors.cyanAccent[100],
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              backgroundColor: AppColor.floating,
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
                color:AppColor.bottomBar,
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
                      color:AppColor.white,
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
                      color:AppColor.white,
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
                      color:AppColor.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
