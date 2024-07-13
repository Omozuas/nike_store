import 'package:get/get.dart';
import 'package:nike_store/views/cartPage_screen.dart';
import 'package:nike_store/views/home-screen.dart';
// import 'package:nike_store/views/viewProduct_screen.dart';

class BottomNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screen = [HomeScreen(), CartpageScreen()];
}
