import 'package:get/get.dart';
import 'package:nike_store/views/allProducts_screen/allProduct.dart';

import 'package:nike_store/views/home_screen/home-screen.dart';
import 'package:nike_store/views/orders_screen/orders_page.dart';
// import 'package:nike_store/views/viewProduct_screen.dart';

class BottomNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screen = [HomeScreen(), AllProduct(), OrdersPage()];
}
