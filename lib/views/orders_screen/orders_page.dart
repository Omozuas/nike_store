import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_store/globalColor/colorsHex.dart';
import 'package:nike_store/routes/orderController.dart';
import 'package:nike_store/views/wishlist_screen/wishList.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return SafeArea(
        child: Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AG-Ezenard',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.search,
                    size: 25,
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WishListPage()));
                    },
                    icon: Icon(
                      CupertinoIcons.heart,
                      size: 25,
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: () => controller.selectedIndex.value = 0,
                      child: Container(
                        width: 170,
                        child: Column(
                          children: [
                            Text(
                              'Active orders',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                            Divider(
                              thickness: 4,
                              color: controller.selectedIndex.value == 0
                                  ? GlobalColors.black
                                  : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: () => controller.selectedIndex.value = 1,
                      child: Container(
                        width: 170,
                        child: Column(
                          children: [
                            Text(
                              'Completed orders',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                            Divider(
                              thickness: 4,
                              color: controller.selectedIndex.value == 1
                                  ? GlobalColors.black
                                  : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(height: 10),
          Obx(() => controller.screen[controller.selectedIndex.value])
        ],
      ),
    ));
  }
}
