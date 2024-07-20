import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_store/apis/models/listOfProductItem.dart';
import 'package:nike_store/apis/timbu_api.dart';
import 'package:nike_store/db/cartdb.dart';
import 'package:nike_store/db/sharedPrefrence_db.dart';
import 'package:nike_store/globalColor/colorsHex.dart';
import 'package:nike_store/routes/BottomNavController.dart';
import 'package:nike_store/views/cart_screen/cartPage_screen.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    super.initState();
    getAllProduct();
  }

  List<Item> _list = [];

  Future<void> getAllProduct() async {
    final get = Provider.of<ApiProvider>(context, listen: false);
    final get1 = Provider.of<DataBase>(context, listen: false);
    get.getProduct().then((value) => {_list = value.items});
    String specialoffer = "9e0703135d0042f1b99f34667e9c1fcc";
    String featuredoffer = "85d0da23d6ae46f386663eabcb778397";
    String newArivalss = "d4b8216df2ef45429625767b7e8d931b";
    await get1.loadProductsFromPreferences();
    await get1.newArivalCategoryId(newArivalss);
    await get1.ourSpecialOfferCategoryId(specialoffer);
    await get1.featuredSneakersCategoryId(featuredoffer);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationController());
    final get1 = context.watch<CartProvider>();
    return Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () {
            return getAllProduct();
          },
          child: SingleChildScrollView(
            child: Obx(() => controller.screen[controller.selectedIndex.value]),
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
              height: 80,
              decoration: BoxDecoration(shape: BoxShape.rectangle),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => controller.selectedIndex.value = 0,
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.house_alt_fill,
                              color: controller.selectedIndex.value == 0
                                  ? GlobalColors.blue
                                  : Colors.black,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: controller.selectedIndex.value == 0
                                    ? GlobalColors.blue
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.selectedIndex.value = 1,
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.dashboard_outlined,
                              color: controller.selectedIndex.value == 1
                                  ? GlobalColors.blue
                                  : Colors.black,
                            ),
                            Text(
                              'All Products',
                              style: TextStyle(
                                color: controller.selectedIndex.value == 1
                                    ? GlobalColors.blue
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartpageScreen()));
                      },
                      child: Container(
                        width: 34,
                        color: Colors.transparent,
                        child: Stack(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.shopping_cart,
                                color: Colors.black,
                              ),
                              Text(
                                'Cart',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 0.3,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                '${get1.getTotalItemCount().toString()}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.selectedIndex.value = 2,
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.badge_outlined,
                              color: controller.selectedIndex.value == 2
                                  ? GlobalColors.blue
                                  : Colors.black,
                            ),
                            Text(
                              'My Orders',
                              style: TextStyle(
                                color: controller.selectedIndex.value == 2
                                    ? GlobalColors.blue
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.profile_circled,
                              color: Colors.black,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
