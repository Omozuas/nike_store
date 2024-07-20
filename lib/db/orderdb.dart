import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:nike_store/apis/models/orderModel.dart';
import 'package:uuid/uuid.dart';

class OrderdbProvider with ChangeNotifier {
  List<Ordermodel> orders = [];
  List<Ordermodel> completed = [];
  List<Ordermodel> pending = [];

  bool _isLoading = false;
  bool get loading => _isLoading;
  List<Ordermodel> get completedOrders => completed;
  List<Ordermodel> get pendingOrders => pending;
  setLoading(bool value) {
    _isLoading = value;
  }

  // Method to add an order
  void addOrder(Ordermodel order) {
    final uuid = Uuid();
    order.orderId = uuid.v4(); // Generate a unique ID for the order
    order.date = '${DateTime.timestamp()}';
    order.productItem = List.from(order.productItem);
    orders.add(order);
    if (order.status == 'completed') {
      completed.add(order);
    } else if (order.status == 'pending') {
      pending.add(order);
      _startPendingTimer(order);
    }

    notifyListeners();
  }

  // Method to remove an order by ID
  void removeOrderById(String id) {
    orders.removeWhere((order) => order.orderId == id);
    notifyListeners();
  }

  // Method to get a single order by ID
  Ordermodel? getOrderById(String id) {
    try {
      return orders.firstWhere((order) => order.orderId == id);
    } catch (e) {
      return null; // Return null if no order is found
    }
  }

  // Method to start a timer for pending orders
  void _startPendingTimer(Ordermodel order) {
    Timer(Duration(minutes: 1), () {
      _completeOrder(order.orderId!);
      print('order updated');
    });
  }

  // Method to mark an order as completed
  void _completeOrder(String orderId) {
    final order = getOrderById(orderId);
    if (order != null && order.status == 'pending') {
      order.status = 'completed';
      pending.remove(order);
      completed.add(order);
      notifyListeners();
    }
  }

  // Method to find orders with status 'pending'
  List<Ordermodel> getPendingOrders() {
    return pending =
        orders.where((order) => order.status == 'pending').toList();
  }

  // Method to find orders with status 'completed'
  List<Ordermodel> getCompletedOrders() {
    return completed =
        orders.where((order) => order.status == 'completed').toList();
  }
}
