import 'package:get/get.dart';
import 'package:nike_store/views/orders_screen/activeOrder.dart';
import 'package:nike_store/views/orders_screen/completedOrders.dart';

class OrderController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screen = [ActiveOrder(), CompletedOrders()];
}
