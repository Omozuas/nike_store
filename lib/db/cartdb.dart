import 'package:flutter/material.dart';
import 'package:nike_store/apis/models/cart_model.dart';

List<CartModel> cart = [];

class CartProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get loading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
  }

  void addToCart(CartModel newItem) {
    setLoading(true);
    // Check if the item already exists in the cart
    int index = cart.indexWhere((item) =>
        item.id == newItem.id &&
        item.size == newItem.size &&
        item.colour == newItem.colour);
    if (index != -1) {
      // If item exists, increase the count
      cart[index].count += newItem.count;
      setLoading(false);
      notifyListeners();
    } else {
      // If item does not exist, add it to the cart
      cart.add(newItem);
      setLoading(false);
      notifyListeners();
    }
    setLoading(false);
    notifyListeners();
  }

  // Optionally, you can also implement a method to remove an item from the cart
  void removeFromCart(String itemId) {
    setLoading(true);
    cart.removeWhere((item) => item.id == itemId);
    setLoading(false);
    notifyListeners();
  }

  // Method to clear the cart
  void clearCart() {
    setLoading(true);
    cart.clear();
    setLoading(false);
    notifyListeners();
  }

  // Method to get total count of items in the cart
  int getTotalItemCount() {
    int total = 0;
    for (var item in cart) {
      total += item.count;
    }
    return total;
  }

  // Method to get total price of items in the cart
  double getTotalPrice() {
    double totalPrice = 0;
    for (var item in cart) {
      totalPrice += item.price * item.count;
    }

    return totalPrice;
  }

  // Method to increment the count of an item in the cart
  void incrementItemCount(String itemId) {
    int index = cart.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      cart[index].count++;
      setLoading(false);
      notifyListeners();
    }
  }

  // Method to decrement the count of an item in the cart
  void decrementItemCount(String itemId) {
    int index = cart.indexWhere((item) => item.id == itemId);
    if (index != -1 && cart[index].count > 1) {
      cart[index].count--;
      setLoading(false);
      notifyListeners();
    }
  }
}
